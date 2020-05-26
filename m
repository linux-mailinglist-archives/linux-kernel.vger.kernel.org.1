Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92C841A4BEE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 00:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgDJWSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 18:18:37 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35474 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgDJWS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 18:18:26 -0400
Received: by mail-pj1-f67.google.com with SMTP id mn19so1230894pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 15:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JjUK3hCgG4ZVP2cWUyMCGx3upUSYjvrftcm9fZ76CII=;
        b=Nyq6OxaN+zvvfmKkmfqed97hvOgJeuG7t2F2hgQMntVcHfYzVmfCZSA0sofUwi4fc2
         MVFsZr6W1J2Au1LTfMzh7i4sXkhJe2l6FDr5qfSZgpI4sZhvz2oOWhjK0554O8NF1ahh
         JmfHga1PW8S9Ow9Y6sfCb2wkM0/FrwWdqxhwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JjUK3hCgG4ZVP2cWUyMCGx3upUSYjvrftcm9fZ76CII=;
        b=q62e4DLk9uqebOQefUvalAoITz26WdXMVaYKcaxfm7YpQI7SpKYrtTKrg29S7QHTIK
         NWXdrRzQezs8qVlyqKvykB7Hxh5iVRHbLThRoO6gIH9B9DB9Q/MAQyGz2YairRKDVvgk
         q3mrj7OVmITZ/Sd98Xbno+bkuC9eic/58Y3CI8P0pM2aFhEJWM4/X11D0JszS1xZYxtD
         YU6CY96I5Rb6cFiGIr5uO9B94cp/Ni0wVxblSqVifGVnJm635Z2BcdWILyvbZSP+rkXV
         C0BUkl7aybUnAZFKtSFJGITBXF12z2cgEgyGs7JZ4omXMPx7JGjfgaBu5H0fYr+BDZRF
         G4hg==
X-Gm-Message-State: AGi0PuYj82Io8RDfeV2awfuaLkcm3lvTPkB4KAXB+BKNy6zl6VzU/R59
        Ij6mkZCqSeif6bb6egPeKaQeWg==
X-Google-Smtp-Source: APiQypI1k7F2ESHdo89rqD3FVQ7JzUVJ9BLRyRi3u53jOxnBFX8vHZpXSD/dycmaKpD8jRimhbe90w==
X-Received: by 2002:a17:902:70c1:: with SMTP id l1mr6294862plt.298.1586557106006;
        Fri, 10 Apr 2020 15:18:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id x2sm2646600pfq.92.2020.04.10.15.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 15:18:25 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     hpa@zytor.com, kgdb-bugreport@lists.sourceforge.net,
        corbet@lwn.net, frowand.list@gmail.com, tglx@linutronix.de,
        jslaby@suse.com, linux-serial@vger.kernel.org, mingo@redhat.com,
        will@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com,
        Douglas Anderson <dianders@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] Documentation: kgdboc: Document new earlycon_kgdboc parameter
Date:   Fri, 10 Apr 2020 15:17:24 -0700
Message-Id: <20200410151632.5.I7d5eb42c6180c831d47aef1af44d0b8be3fac559@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200410221726.36442-1-dianders@chromium.org>
References: <20200410221726.36442-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent patch ("kgdboc: Add earlycon_kgdboc to support early kgdb
using boot consoles") adds a new kernel command line parameter.
Document it.

Note that the patch adding the feature does some comparing/contrasting
of "earlycon_kgdboc" vs. the existing "ekgdboc".  See that patch for
more details, but briefly "ekgdboc" can be used _instead_ of "kgdboc"
and just makes "kgdboc" do its normal initialization early (only works
if your tty driver is already ready).  The new "earlycon_kgdboc" works
in combination with "kgdboc" and is backed by boot consoles.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../admin-guide/kernel-parameters.txt         | 20 +++++++++++++++++++
 Documentation/dev-tools/kgdb.rst              | 14 +++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c07815d230bc..37dc2db13743 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1124,6 +1124,22 @@
 			address must be provided, and the serial port must
 			already be setup and configured.
 
+	earlycon_kgdboc=	[KGDB,HW]
+			If the boot console provides the ability to read
+			characters and can work in polling mode, you can use
+			this parameter to tell kgdb to use it as a backend
+			until the normal console is registered. Intended to
+			be used together with the kgdboc parameter which
+			specifies the normal console to transition to.
+
+			The the name of the early console should be specified
+			as the value of this parameter. Note that the name of
+			the early console might be different than the tty
+			name passed to kgdboc. If only one boot console with
+			a read() function is enabled it's OK to leave the
+			value blank and the first boot console that implements
+			read() will be picked.
+
 	earlyprintk=	[X86,SH,ARM,M68k,S390]
 			earlyprintk=vga
 			earlyprintk=sclp
@@ -1182,6 +1198,10 @@
 			This is designed to be used in conjunction with
 			the boot argument: earlyprintk=vga
 
+			This parameter works in place of the kgdboc parameter
+			but can only be used if the backing tty is available
+			very early in the boot process.
+
 	edd=		[EDD]
 			Format: {"off" | "on" | "skip[mbr]"}
 
diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/kgdb.rst
index d38be58f872a..c0b321403d9a 100644
--- a/Documentation/dev-tools/kgdb.rst
+++ b/Documentation/dev-tools/kgdb.rst
@@ -274,6 +274,20 @@ don't like this are to hack gdb to send the :kbd:`SysRq-G` for you as well as
 on the initial connect, or to use a debugger proxy that allows an
 unmodified gdb to do the debugging.
 
+Kernel parameter: ``earlycon_kgdboc``
+-------------------------------------
+
+If you specify the kernel parameter ``earlycon_kgdboc`` and your serial
+driver registers a boot console that supports polling (doesn't need
+interrupts and implements a nonblocking read() function) kgdb will attempt
+to work using the boot console until it can transition to the regular
+tty driver specified by the ``kgdboc`` parameter.
+
+Normally there is only one boot console (especially that implements the
+read() function) so just adding ``earlycon_kgdboc`` on its own is
+sufficient to make this work.  If you have more than one boot console you
+can add the boot console's name to differentiate.
+
 Kernel parameter: ``kgdbwait``
 ------------------------------
 
-- 
2.26.0.110.g2183baf09c-goog

