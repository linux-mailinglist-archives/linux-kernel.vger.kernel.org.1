Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B85E2B71A4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgKQWgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:36:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726433AbgKQWgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605652577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zN721c7S6whBVWrMK+XsLSulLTRzivYrlWK+dANFonY=;
        b=a+pRKKJ5nysPEGWetNySzDFb/MEch4VPWH4yVF4ziVl11R+c5ZNXr4Mkh6Q8QBrWyNsCdX
        CX1t4ZJT0uPdcnv8am15pPmGc8ubUWAOq1qxMnwHLY/3/zmm5OSvMIfTqocZCw3B4jQr+J
        jTegFPiBDTW+5c65hTf/aj2as3uc2Qo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-Ouizj4sgOcev0hVNv0tolA-1; Tue, 17 Nov 2020 17:36:15 -0500
X-MC-Unique: Ouizj4sgOcev0hVNv0tolA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E6871882FA5;
        Tue, 17 Nov 2020 22:36:14 +0000 (UTC)
Received: from localhost (ovpn-115-101.rdu2.redhat.com [10.10.115.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0058F5D9CD;
        Tue, 17 Nov 2020 22:36:13 +0000 (UTC)
Date:   Tue, 17 Nov 2020 17:36:12 -0500
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [RFC] Add kernel-doc test script
Message-ID: <20201117223612.GN1235237@habkost.net>
References: <20201030144713.201372-1-pbonzini@redhat.com>
 <20201030144713.201372-3-pbonzini@redhat.com>
 <20201113152106.7b4a07ee@lwn.net>
 <20201113223912.GK17076@casper.infradead.org>
 <20201117212452.GM1235237@habkost.net>
 <20201117213051.GA29991@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201117213051.GA29991@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a kernel-doc test script to tools/testing/kernel-doc.

radix_tree_lookup_slot test case provided by Matthew Wilcox.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tools/testing/kernel-doc/test-case.h          | 111 ++++++++++
 .../testing/kernel-doc/test-case.man.expected | 150 ++++++++++++++
 .../kernel-doc/test-case.none.expected        |   0
 .../kernel-doc/test-case.rst2.expected        | 195 ++++++++++++++++++
 .../kernel-doc/test-case.rst3.expected        | 195 ++++++++++++++++++
 tools/testing/kernel-doc/test.sh              |  90 ++++++++
 6 files changed, 741 insertions(+)
 create mode 100644 tools/testing/kernel-doc/test-case.h
 create mode 100644 tools/testing/kernel-doc/test-case.man.expected
 create mode 100644 tools/testing/kernel-doc/test-case.none.expected
 create mode 100644 tools/testing/kernel-doc/test-case.rst2.expected
 create mode 100644 tools/testing/kernel-doc/test-case.rst3.expected
 create mode 100755 tools/testing/kernel-doc/test.sh

diff --git a/tools/testing/kernel-doc/test-case.h b/tools/testing/kernel-doc/test-case.h
new file mode 100644
index 0000000000000..6d4e1f6b99631
--- /dev/null
+++ b/tools/testing/kernel-doc/test-case.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/**
+ * DOC: kernel-doc test case
+ *
+ * ``test-case.h`` contains a series of declarations and
+ * kernel-doc comments. The expected kernel-doc output can be
+ * found at ``test-case.rst.expected``.
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
+ * A typedef for a function type (not a function pointer), wit
+ * parenthesis around the function name.
+ */
+typedef void (func_par)(int a);
+
+/**
+ * struct struct_name1 - a struct
+ * @i: an int field
+ * @j: an int pointer
+ * @u: a union field
+ * @sptr: pointer to a `struct_name1`
+ *
+ * A simple struct with multiple fields.
+ *
+ * Here's a reference to another struct type: &struct struct_name2.
+ */
+struct struct_name1 {
+	int i, *j;
+	union {
+		int i;
+		const char *s;
+	} u;
+	struct struct_name1 *sptr;
+	/**
+	 * @field_with_inline_doc: another way to document struct fields
+	 *
+	 * This field is documented inside the struct definition,
+	 * closer to the field declaration instead the doc comment at
+	 * the top.
+	 */
+	int field_with_inline_doc;
+	/**
+	 * @func: a function pointer
+	 *
+	 * Parsing a function pointer field involves some tricks to handle
+	 * the commas properly.
+	 */
+	int (*func)(int x, struct struct_name1 *p);
+	/** @bitmap: a bitmap */
+	DECLARE_BITMAP(bitmap, 128);
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
+	int x, y;
+	struct struct_name1 another;
+} struct_name2;
+
+/**
+ * radix_tree_lookup_slot - lookup a slot in a radix tree
+ * @root:		radix tree root
+ * @index:	 index key
+ *
+ * Returns:  the slot corresponding to the position @index in the
+ * radix tree @root. This is useful for update-if-exists operations.
+ *
+ * This function can be called under rcu_read_lock iff the slot is not
+ * modified by radix_tree_replace_slot(), otherwise it must be called
+ * exclusive from other writers. Any dereference of the slot must be done
+ * using radix_tree_deref_slot().
+ *
+ * We used to have a problem with multiple ``*`` in the return type, and
+ * we've also had problems with adornments like __rcu).
+ */
+void __rcu **radix_tree_lookup_slot(const struct radix_tree_root *root,
+					unsigned long index)
+{ }
+
+/**
+ * SOME_MACRO - a macro that takes a few arguments
+ * @a: first argument
+ * @b: second argument
+ */
+#define SOME_MACRO(a, b) \
+	{ multi_line_macro_definition(a); \
+	  second_line(b); \
+	}
diff --git a/tools/testing/kernel-doc/test-case.man.expected b/tools/testing/kernel-doc/test-case.man.expected
new file mode 100644
index 0000000000000..6be2583469f04
--- /dev/null
+++ b/tools/testing/kernel-doc/test-case.man.expected
@@ -0,0 +1,150 @@
+.TH "Kernel API" 9 "Kernel API" "August 1991" "API Manual" LINUX
+.SH "kernel-doc test case"
+``test-case.h contains a series of declarations and
+kernel-doc comments. The expected kernel-doc output can be
+found at test-case.rst.expected``.
+.TH "void_func_ptr" 9 "void_func_ptr" "August 1991" "Kernel Hacker's Manual" LINUX
+.SH NAME
+void_func_ptr \- pointer to a function
+.SH SYNOPSIS
+.B "void" void_func_ptr
+.BI "(int a "  ","
+.BI "struct struct_name1 *b "  ");"
+.SH ARGUMENTS
+.IP "a" 12
+first argument
+.IP "b" 12
+second argument
+.TH "int_ptr_func_ptr" 9 "int_ptr_func_ptr" "August 1991" "Kernel Hacker's Manual" LINUX
+.SH NAME
+int_ptr_func_ptr \- a pointer to a function returning a pointer
+.SH SYNOPSIS
+.B "int *" int_ptr_func_ptr
+.BI "(int a "  ");"
+.SH ARGUMENTS
+.IP "a" 12
+argument
+.TH "func_par" 9 "func_par" "August 1991" "Kernel Hacker's Manual" LINUX
+.SH NAME
+func_par \- a function, with parenthesis
+.SH SYNOPSIS
+.B "void" func_par
+.BI "(int a "  ");"
+.SH ARGUMENTS
+.IP "a" 12
+argument
+.SH "DESCRIPTION"
+A typedef for a function type (not a function pointer), wit
+parenthesis around the function name.
+.TH "Kernel API" 9 "struct struct_name1" "August 1991" "API Manual" LINUX
+.SH NAME
+struct struct_name1 \- a struct
+.SH SYNOPSIS
+struct struct_name1 {
+.br
+.BI "    int i, *j;"
+.br
+.BI "    union {"
+.br
+.BI "      int i;"
+.br
+.BI "      const char *s;"
+.br
+.BI "    } u;"
+.br
+.BI "    struct struct_name1 *sptr;"
+.br
+.BI "    int field_with_inline_doc;"
+.br
+.BI "    int (*func)(int x, struct struct_name1 *p);"
+.br
+.BI "    unsigned long bitmap[BITS_TO_LONGS(128)];"
+.br
+.BI "
+};
+.br
+
+.SH Members
+.IP "i" 12
+an int field
+.IP "j" 12
+an int pointer
+.IP "u" 12
+a union field
+.IP "sptr" 12
+pointer to a `struct_name1`
+.IP "field_with_inline_doc" 12
+another way to document struct fields
+
+This field is documented inside the struct definition,
+closer to the field declaration instead the doc comment at
+the top.
+.IP "func" 12
+a function pointer
+
+Parsing a function pointer field involves some tricks to handle
+the commas properly.
+.IP "bitmap" 12
+a bitmap 
+.SH "Description"
+A simple struct with multiple fields.
+
+Here's a reference to another struct type: \fIstruct struct_name2\fP.
+.TH "Kernel API" 9 "struct struct_name2" "August 1991" "API Manual" LINUX
+.SH NAME
+struct struct_name2 \- another struct
+.SH SYNOPSIS
+struct struct_name2 {
+.br
+.BI "    int x, y;"
+.br
+.BI "    struct struct_name1 another;"
+.br
+.BI "
+};
+.br
+
+.SH Members
+.IP "x" 12
+first field
+.IP "y" 12
+second field
+.IP "another" 12
+another struct
+.SH "Description"
+This struct is defined inside a typedef declaration.
+.TH "radix_tree_lookup_slot" 9 "radix_tree_lookup_slot" "August 1991" "Kernel Hacker's Manual" LINUX
+.SH NAME
+radix_tree_lookup_slot \- lookup a slot in a radix tree
+.SH SYNOPSIS
+.B "void __rcu **" radix_tree_lookup_slot
+.BI "(const struct radix_tree_root *root "  ","
+.BI "unsigned long index "  ");"
+.SH ARGUMENTS
+.IP "root" 12
+radix tree root
+.IP "index" 12
+index key
+.SH "RETURN"
+the slot corresponding to the position \fIindex\fP in the
+radix tree \fIroot\fP. This is useful for update-if-exists operations.
+.SH "DESCRIPTION"
+This function can be called under rcu_read_lock iff the slot is not
+modified by \fBradix_tree_replace_slot\fP, otherwise it must be called
+exclusive from other writers. Any dereference of the slot must be done
+using \fBradix_tree_deref_slot\fP.
+
+We used to have a problem with multiple ``*`` in the return type, and
+we've also had problems with adornments like __rcu).
+.TH "SOME_MACRO" 9 "SOME_MACRO" "August 1991" "Kernel Hacker's Manual" LINUX
+.SH NAME
+SOME_MACRO \- a macro that takes a few arguments
+.SH SYNOPSIS
+.B "SOME_MACRO
+.BI "(a "  ","
+.BI "b "  ");"
+.SH ARGUMENTS
+.IP "a" 12
+first argument
+.IP "b" 12
+second argument
diff --git a/tools/testing/kernel-doc/test-case.none.expected b/tools/testing/kernel-doc/test-case.none.expected
new file mode 100644
index 0000000000000..e69de29bb2d1d
diff --git a/tools/testing/kernel-doc/test-case.rst2.expected b/tools/testing/kernel-doc/test-case.rst2.expected
new file mode 100644
index 0000000000000..66ae737a808f2
--- /dev/null
+++ b/tools/testing/kernel-doc/test-case.rst2.expected
@@ -0,0 +1,195 @@
+**kernel-doc test case**
+
+
+``test-case.h`` contains a series of declarations and
+kernel-doc comments. The expected kernel-doc output can be
+found at ``test-case.rst.expected``.
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
+A typedef for a function type (not a function pointer), wit
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
+  a union field
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
+.. c:function:: void __rcu ** radix_tree_lookup_slot (const struct radix_tree_root *root, unsigned long index)
+
+   lookup a slot in a radix tree
+
+**Parameters**
+
+``const struct radix_tree_root *root``
+  radix tree root
+
+``unsigned long index``
+  index key
+
+**Return**
+
+the slot corresponding to the position **index** in the
+radix tree **root**. This is useful for update-if-exists operations.
+
+**Description**
+
+This function can be called under rcu_read_lock iff the slot is not
+modified by radix_tree_replace_slot(), otherwise it must be called
+exclusive from other writers. Any dereference of the slot must be done
+using radix_tree_deref_slot().
+
+We used to have a problem with multiple ``*`` in the return type, and
+we've also had problems with adornments like __rcu).
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
diff --git a/tools/testing/kernel-doc/test-case.rst3.expected b/tools/testing/kernel-doc/test-case.rst3.expected
new file mode 100644
index 0000000000000..66ae737a808f2
--- /dev/null
+++ b/tools/testing/kernel-doc/test-case.rst3.expected
@@ -0,0 +1,195 @@
+**kernel-doc test case**
+
+
+``test-case.h`` contains a series of declarations and
+kernel-doc comments. The expected kernel-doc output can be
+found at ``test-case.rst.expected``.
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
+A typedef for a function type (not a function pointer), wit
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
+  a union field
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
+.. c:function:: void __rcu ** radix_tree_lookup_slot (const struct radix_tree_root *root, unsigned long index)
+
+   lookup a slot in a radix tree
+
+**Parameters**
+
+``const struct radix_tree_root *root``
+  radix tree root
+
+``unsigned long index``
+  index key
+
+**Return**
+
+the slot corresponding to the position **index** in the
+radix tree **root**. This is useful for update-if-exists operations.
+
+**Description**
+
+This function can be called under rcu_read_lock iff the slot is not
+modified by radix_tree_replace_slot(), otherwise it must be called
+exclusive from other writers. Any dereference of the slot must be done
+using radix_tree_deref_slot().
+
+We used to have a problem with multiple ``*`` in the return type, and
+we've also had problems with adornments like __rcu).
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
diff --git a/tools/testing/kernel-doc/test.sh b/tools/testing/kernel-doc/test.sh
new file mode 100755
index 0000000000000..37042c5453823
--- /dev/null
+++ b/tools/testing/kernel-doc/test.sh
@@ -0,0 +1,90 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020, Red Hat Inc.
+# Author: Eduardo Habkost <ehabkost@redhat.com>
+#
+# Black box test script for kernel-doc
+
+set -e
+mydir="$(dirname "$0")"
+
+usage()
+{
+    echo "Usage: $0 [--refresh] [--kernel-doc KERNELDOC_BINARY]"
+}
+
+refresh=no
+kerneldoc="$mydir/../../../scripts/kernel-doc"
+while [ "$#" -gt 0 ];do
+    case "$1" in
+        -h|--help)
+            usage
+            exit 0
+        ;;
+        --refresh)
+            refresh=yes
+            shift
+        ;;
+        --kernel-doc)
+            shift
+            kerneldoc="$1"
+            shift
+        ;;
+        *)
+            echo "Invalid argument: $1" >&2
+            usage >&2
+            exit 1
+        ;;
+    esac
+done
+
+tmp="$(mktemp -d)"
+trap 'rm -rf "$tmp"' EXIT
+
+test()
+{
+    local suffix="$1"
+    shift
+
+    if ! "$kerneldoc" "$@" "$mydir/test-case.h" \
+         > "$tmp/test-case.$suffix.actual" \
+         2> "$tmp/test-case.$suffix.stderr" || \
+       [ -s "$tmp/test-case.$suffix.stderr" ];then
+        cat "$tmp/test-case.$suffix.stderr" >&2
+        echo "$suffix: kernel-doc $* failed" >&2
+        return 1
+    fi
+
+    if diff -u "$mydir/test-case.$suffix.expected" \
+               "$tmp/test-case.$suffix.actual";then
+        echo "$suffix: OK" >&2
+    else
+        echo "kernel-doc output mismatch for: $*" >&2
+        if [ "$refresh" = yes ];then
+            cp "$tmp/test-case.$suffix.actual" \
+              "$mydir/test-case.$suffix.expected"
+        fi
+        return 1
+    fi
+}
+
+if [ ! -x "$kerneldoc" ];then
+    echo "kernel-doc is not executable: $kerneldoc" >&2
+    exit 1
+fi
+
+# the -man output includes the build date
+export KBUILD_BUILD_TIMESTAMP=1991-08-25
+
+ok=yes
+
+# don't even try to test other formats if -none fails:
+test none -none || exit 1
+
+test rst2 -rst -sphinx-version 3.0.0 || ok=no
+test rst3 -rst -sphinx-version 3.0.0 || ok=no
+test man -man || ok=no
+
+if [ "$ok" != "yes" ];then
+    exit 1
+fi
-- 
2.28.0

