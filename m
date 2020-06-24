Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB51E207DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 22:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406361AbgFXU6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 16:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391550AbgFXU6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:58:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E60C061798
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:58:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n11so3575640ybg.15
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/YfJhHqk1scz1aBXF0mupkQea8lbBQgP2jeC+IACUDE=;
        b=eBb2r/O+3xD/ft1cWQIYq+lLT5MaZcDKCI7F68NCZy5mtkJDNhWzHGgMGNZjbp5vY2
         NeciIBXPHqDHAr515OD+KEI2SwbSQA3wPry4syrluMYmbIYDoGubxlmgh9jyRlLOoHz5
         p4aoDDsXGCW7wnWAlLUMV8zs3lliqsQjwHQ3f/IRxPoalCwAHzoMzbTu3F1aBupYM8jY
         RJXyTQ3a1l5kZUWbyWsbEikRBkGpV5M+0D3Trh1EaZC6LuABuarRYjnjmK+YSshwXwQu
         +pk7yF5eODqLsJrD/Gc4h/AznuIk8Jq2hwInTWrfIN5TI1VZdP1CxKJc8TVkKATdArhv
         rkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/YfJhHqk1scz1aBXF0mupkQea8lbBQgP2jeC+IACUDE=;
        b=eRCMTsTwN8vz/XUZ2TVFCJqHqItUIXesocg8xWcKxUKDLN7RAU5QZipzj8ubb9G1/y
         VrcmzzmF+iEWgjdaQ1qccmGBL2rT3r85yGtx6Lb6DZTO1a/ZzJipFCc0YxN4O15x41DM
         c3lC8agajkXJZqwr0oB/o12puVQnPIKmHGNrmQ1ShooxiM5VqwVjSeoE2UYfIx/Krb9j
         cpG6beDRFXdKzuc0JpbOzA1iFbkIRe6k5c+KBHAZphXnuKg98vYWQy118Obozt1qKUva
         dTYFF9acy8+ancFiV2TkNE/SPGCmaEyKczSNcaMfTiG4SBMTR3WFI56bswLvuGhchgMz
         Ywzw==
X-Gm-Message-State: AOAM531H5gritX8Ev80sYAp2Azhgh4/X0GHuFp9RmKBnLzbesqXPPFzJ
        GoU9PsFEKLdQaZ54234Xdnfe/Nvz7CAXY2JftGUcPQ==
X-Google-Smtp-Source: ABdhPJyzMN1O9F20c44aUZ3Rj+xXWGPWk9fw0REl0xzDcZiFgklg99lb7/rTyyzMpJHoIh8oBhPbhqyjNv0vmkzqL5BxQQ==
X-Received: by 2002:a25:2d63:: with SMTP id s35mr27292035ybe.367.1593032308955;
 Wed, 24 Jun 2020 13:58:28 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:55:50 -0700
In-Reply-To: <20200624205550.215599-1-brendanhiggins@google.com>
Message-Id: <20200624205550.215599-12-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200624205550.215599-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 11/11] Documentation: kunit: add a brief blurb about kunit_test_suite
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a brief blurb saying how and when the kunit_test_suite() macro
works to the usage documentation.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 3c3fe8b5feccf..961d3ea3ca19a 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -211,6 +211,11 @@ KUnit test framework.
 .. note::
    A test case will only be run if it is associated with a test suite.
 
+``kunit_test_suite(...)`` is a macro which tells the linker to put the specified
+test suite in a special linker section so that it can be run by KUnit either
+after late_init, or when the test module is loaded (depending on whether the
+test was built in or not).
+
 For more information on these types of things see the :doc:`api/test`.
 
 Isolating Behavior
-- 
2.27.0.212.ge8ba1cc988-goog

