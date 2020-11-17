Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758542B70E3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 22:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgKQVY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 16:24:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbgKQVY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 16:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605648297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S9Sdw3rsrMeGbshhPqJW5JIbbH1tSidQC9dyk6u1X20=;
        b=R39Z3pXhURJJmp3b/QdGgCrXcLoYdR8KMZCZZXFuuRWtDMiU5r1QnjZkzOoco08R7qmjt7
        9p3WBUm5IWOFf4H1nY1WNwuTcnLMET0RBefSk48iFpyvJ5N4tebdwm5SESFi1UiYS7+QxM
        6V4HUajSwSMguBeOv2nGR3WEUywhprU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-_eG3P1QaPk2PwBpCjavISA-1; Tue, 17 Nov 2020 16:24:55 -0500
X-MC-Unique: _eG3P1QaPk2PwBpCjavISA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AED1610866A6;
        Tue, 17 Nov 2020 21:24:53 +0000 (UTC)
Received: from localhost (ovpn-115-101.rdu2.redhat.com [10.10.115.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66E7260C05;
        Tue, 17 Nov 2020 21:24:53 +0000 (UTC)
Date:   Tue, 17 Nov 2020 16:24:52 -0500
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] kernel-doc: Handle function typedefs without
 asterisks
Message-ID: <20201117212452.GM1235237@habkost.net>
References: <20201030144713.201372-1-pbonzini@redhat.com>
 <20201030144713.201372-3-pbonzini@redhat.com>
 <20201113152106.7b4a07ee@lwn.net>
 <20201113223912.GK17076@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201113223912.GK17076@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 10:39:12PM +0000, Matthew Wilcox wrote:
> On Fri, Nov 13, 2020 at 03:21:06PM -0700, Jonathan Corbet wrote:
> > On Fri, 30 Oct 2020 15:47:13 +0100
> > Paolo Bonzini <pbonzini@redhat.com> wrote:
> > 
> > > From: Eduardo Habkost <ehabkost@redhat.com>
> > > 
> > > Example of typedef that was not parsed by kernel-doc:
> > > 
> > >   typedef void (ObjectUnparent)(Object *obj);
> > > 
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > So as you've undoubtedly noticed, reading those kernel-doc regexes is ... a
> > wee bit on the painful side.  Trying to compare two of them in a patch to
> > figure out what you have done is even worse.  I suspect we want these
> > patches, but can you please supply a changelog that describes the change? 
> 
> Better ... can we have a test suite for the regexes and make patches to
> them include updates to the test suite?  They have clearly passed the
> point of human understanding ;-)

Would a simple black box test script like this be desirable?

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/kernel-doc-test-case.h            |  89 ++++++++++++
 scripts/kernel-doc-test-case.rst.expected | 167 ++++++++++++++++++++++
 scripts/kernel-doc-test.sh                |  15 ++
 3 files changed, 271 insertions(+)
 create mode 100644 scripts/kernel-doc-test-case.h
 create mode 100644 scripts/kernel-doc-test-case.rst.expected
 create mode 100755 scripts/kernel-doc-test.sh

diff --git a/scripts/kernel-doc-test-case.h b/scripts/kernel-doc-test-case.h
new file mode 100644
index 0000000000000..5cea705d85392
--- /dev/null
+++ b/scripts/kernel-doc-test-case.h
@@ -0,0 +1,89 @@
+/**
+ * DOC: kernel-doc test case
+ *
+ * ``kernel-doc-test-case.h`` contains a series of declarations
+ * and kernel-doc comments. The expected kernel-doc output can be
+ * found at ``kernel-doc-test-case.rst.expected``.
+ */
+
+/**
+ * typedef void_func_ptr - pointer to a function
+ * @a: first argument
+ * @b: second argument
+ */
+typedef void (*void_func_ptr)(int a, struct struct_name1 *b);
+
+/**
+ * typedef int_ptr_func_ptr - a pointer to a function returning a pointer
+ * @a: argument
+ */
+typedef int *(*int_ptr_func_ptr)(int a);
+
+/**
+ * typedef func_par - a function, with parenthesis
+ * @a: argument
+ *
+ * A typedef for a function type (not a function pointer), with
+ * parenthesis around the function name.
+ */
+typedef void (func_par)(int a);
+
+/**
+ * struct struct_name1 - a struct
+ * @i: an int field
+ * @j: an int pointer
+ * @u: an union field
+ * @sptr: pointer to a `struct_name1`
+ *
+ * A simple struct with multiple fields.
+ *
+ * Here's a reference to another struct type: &struct struct_name2.
+ */
+struct struct_name1 {
+    int i, *j;
+    union {
+        int i;
+        const char *s;
+    } u;
+    struct struct_name1 *sptr;
+    /**
+     * @field_with_inline_doc: another way to document struct fields
+     *
+     * This field is documented inside the struct definition,
+     * closer to the field declaration instead the doc comment at
+     * the top.
+     */
+    int field_with_inline_doc;
+    /**
+     * @func: a function pointer
+     *
+     * Parsing a function pointer field involves some tricks to handle
+     * the commas properly.
+     */
+    int (*func)(int x, struct struct_name1 *p);
+    /** @bitmap: a bitmap */
+    DECLARE_BITMAP(bitmap, 128);
+};
+
+/**
+ * struct struct_name2 - another struct
+ * @x: first field
+ * @y: second field
+ * @another: another struct
+ *
+ * This struct is defined inside a typedef declaration.
+ */
+typedef struct struct_name2 {
+    int x, y;
+    struct struct_name1 another;
+} struct_name2;
+
+/**
+ * SOME_MACRO - a macro that takes a few arguments
+ * @a: first argument
+ * @b: second argument
+ */
+#define SOME_MACRO(a, b) \
+    { multi_line_macro_definition(a); \
+      second_line(b); \
+    }
diff --git a/scripts/kernel-doc-test-case.rst.expected b/scripts/kernel-doc-test-case.rst.expected
new file mode 100644
index 0000000000000..4f68931121bb7
--- /dev/null
+++ b/scripts/kernel-doc-test-case.rst.expected
@@ -0,0 +1,167 @@
+**kernel-doc test case**
+
+
+``kernel-doc-test-case.h`` contains a series of declarations
+and kernel-doc comments. The expected kernel-doc output can be
+found at ``kernel-doc-test-case.rst.expected``.
+
+.. c:macro:: void_func_ptr
+
+   **Typedef**: pointer to a function
+
+
+**Syntax**
+
+  ``void void_func_ptr (int a, struct struct_name1 *b)``
+
+**Parameters**
+
+``int a``
+  first argument
+
+``struct struct_name1 *b``
+  second argument
+
+
+.. c:macro:: int_ptr_func_ptr
+
+   **Typedef**: a pointer to a function returning a pointer
+
+
+**Syntax**
+
+  ``int * int_ptr_func_ptr (int a)``
+
+**Parameters**
+
+``int a``
+  argument
+
+
+.. c:macro:: func_par
+
+   **Typedef**: a function, with parenthesis
+
+
+**Syntax**
+
+  ``void func_par (int a)``
+
+**Parameters**
+
+``int a``
+  argument
+
+**Description**
+
+A typedef for a function type (not a function pointer), with
+parenthesis around the function name.
+
+
+
+
+.. c:struct:: struct_name1
+
+   a struct
+
+**Definition**
+
+::
+
+  struct struct_name1 {
+    int i, *j;
+    union {
+      int i;
+      const char *s;
+    } u;
+    struct struct_name1 *sptr;
+    int field_with_inline_doc;
+    int (*func)(int x, struct struct_name1 *p);
+    unsigned long bitmap[BITS_TO_LONGS(128)];
+  };
+
+**Members**
+
+``i``
+  an int field
+
+``j``
+  an int pointer
+
+``u``
+  an union field
+
+``sptr``
+  pointer to a `struct_name1`
+
+``field_with_inline_doc``
+  another way to document struct fields
+  
+  This field is documented inside the struct definition,
+  closer to the field declaration instead the doc comment at
+  the top.
+
+``func``
+  a function pointer
+  
+  Parsing a function pointer field involves some tricks to handle
+  the commas properly.
+
+``bitmap``
+  a bitmap 
+
+
+**Description**
+
+A simple struct with multiple fields.
+
+Here's a reference to another struct type: :c:type:`struct struct_name2 <struct_name2>`.
+
+
+
+
+.. c:struct:: struct_name2
+
+   another struct
+
+**Definition**
+
+::
+
+  struct struct_name2 {
+    int x, y;
+    struct struct_name1 another;
+  };
+
+**Members**
+
+``x``
+  first field
+
+``y``
+  second field
+
+``another``
+  another struct
+
+
+**Description**
+
+This struct is defined inside a typedef declaration.
+
+
+.. c:macro:: SOME_MACRO
+
+``SOME_MACRO (a, b)``
+
+   a macro that takes a few arguments
+
+**Parameters**
+
+``a``
+  first argument
+
+``b``
+  second argument
+
+
diff --git a/scripts/kernel-doc-test.sh b/scripts/kernel-doc-test.sh
new file mode 100755
index 0000000000000..4c96592649451
--- /dev/null
+++ b/scripts/kernel-doc-test.sh
@@ -0,0 +1,15 @@
+#!/bin/bash
+set -e
+mydir="$(dirname "$0")"
+kerneldoc="$mydir/kernel-doc"
+
+tmp="$(mktemp -d)"
+trap 'rm -rf "$tmp"' EXIT
+
+"$kerneldoc" -sphinx-version 3.2.1 -rst "$mydir/kernel-doc-test-case.h" > "$tmp/kernel-doc-test-case.rst.actual" 2>&1
+if diff -u "$mydir/kernel-doc-test-case.rst.expected" "$tmp/kernel-doc-test-case.rst.actual";then
+    echo OK
+else
+    echo kernel-doc output mismatch
+    exit 1
+fi
-- 
2.28.0

-- 
Eduardo

