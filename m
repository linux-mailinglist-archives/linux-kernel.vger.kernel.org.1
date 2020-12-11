Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D4A2D82A3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 00:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437249AbgLKXRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 18:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407109AbgLKXQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 18:16:24 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C38BC06179C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 15:15:42 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id i187so7498845pgd.20
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 15:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=atYrQKwYFomh4/bEAS010ocb5bmiLdSIhCvdMJ/ojyo=;
        b=loJ8I0OVDpiiNai4cT7XiVES7BxHLkS7QBPVfb+gAmt3i6O+26EPYB0f659NPD8y3b
         WAUsITML1kcfDRXv45+3XI1aYuX0tA9iobu4eA7GQnep2tyVT+Got48e+ifREg6JNhFC
         zT3QiuL/BlTpd8NkzgmE1rZZ9dLuSqNVx9gauOK1U8RWzxBmuj9deZyBBfZwnIKLjUMJ
         MjO2h2S+VFtx/Q/len9554fNLXGV84bMFO4Q5littOzUT9waVYn45x9tT0Wir1dHvc7F
         8ENpl9V5D7slUpwj+FbldqEQEnYtmzyzffjR5/0SX6SDyz6CcKgak94kmfQTKOngS2s+
         /37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=atYrQKwYFomh4/bEAS010ocb5bmiLdSIhCvdMJ/ojyo=;
        b=ZF70tG7+YpT1rjSOsfv/U/XvM2BhhpIx/kqJtdE9pKY+p8UTmQIxIXW8Gld69ooguR
         jJ5DBY8BmWqQjQGde5mnoTW2QXhhBmvnUd/KcFYXjxmK/nI41dnvNpK1U3XdNPj0Wmlo
         hO0Gu0CCNwXItgTbXj8ExD8wDBicbilFuv21LOibTrf/7yZX6asky0cfjB5+qOuPrkSE
         ePj8MdtlqWx83y/YthAtwk0lzTEIfESkwWC/EGufWzhsqJw3dHS/j9GQ6DMqTkwylaxN
         eLHnU2MoAEaB1qnC2jEdA/5vwQfDQkRym6Md3mALkcLww6ZA7K5gNbUinzih+c/rI5y7
         p3Wg==
X-Gm-Message-State: AOAM531zApnT+zSlfJ8nv6QBrzrQ/zIxQXEqxJQVGz5hKwr2M8cLzQnp
        QBeAk8EvNW/pEZilvhyUrr6Ob20ZKaTgew==
X-Google-Smtp-Source: ABdhPJz+THJfNO0yYnAjibY98WnJidY9uTtlUuN820D+NYH5vtH/N4mIq5010a/gfacp/r5CbQ7REUYWeH9pEA==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a17:902:b101:b029:da:c50e:cd56 with SMTP
 id q1-20020a170902b101b02900dac50ecd56mr12909894plr.59.1607728541781; Fri, 11
 Dec 2020 15:15:41 -0800 (PST)
Date:   Fri, 11 Dec 2020 15:15:20 -0800
In-Reply-To: <20201211231520.1654036-1-dlatypov@google.com>
Message-Id: <20201211231520.1654036-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20201211231520.1654036-1-dlatypov@google.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH v2 3/3] kunit: tool: move kunitconfig parsing into __init__,
 make it optional
From:   Daniel Latypov <dlatypov@google.com>
To:     davidgow@google.com
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LinuxSourceTree will unceremoniously crash if the user doesn't call
read_kunitconfig() first in a number of functions.

And currently every place we create an instance, the caller also calls
create_kunitconfig() and read_kunitconfig().
Move these instead into __init__() so they can't be forgotten and to
reduce copy-paste.

The https://github.com/google/pytype type-checker complained that
_config wasn't initialized. With this, kunit_tool now type checks
under both pytype and mypy.

Add an optional boolean that can be used to disable this for use cases
in the future where we might not need/want to load the config.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py        | 20 ++++----------------
 tools/testing/kunit/kunit_kernel.py | 25 +++++++++++++------------
 2 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 08951a114654..b58fb3733cfa 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -256,10 +256,7 @@ def main(argv, linux=None):
 			os.mkdir(cli_args.build_dir)
 
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
-
-		linux.create_kunitconfig(cli_args.build_dir)
-		linux.read_kunitconfig(cli_args.build_dir)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		request = KunitRequest(cli_args.raw_output,
 				       cli_args.timeout,
@@ -277,10 +274,7 @@ def main(argv, linux=None):
 			os.mkdir(cli_args.build_dir)
 
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
-
-		linux.create_kunitconfig(cli_args.build_dir)
-		linux.read_kunitconfig(cli_args.build_dir)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		request = KunitConfigRequest(cli_args.build_dir,
 					     cli_args.make_options)
@@ -292,10 +286,7 @@ def main(argv, linux=None):
 			sys.exit(1)
 	elif cli_args.subcommand == 'build':
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
-
-		linux.create_kunitconfig(cli_args.build_dir)
-		linux.read_kunitconfig(cli_args.build_dir)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		request = KunitBuildRequest(cli_args.jobs,
 					    cli_args.build_dir,
@@ -309,10 +300,7 @@ def main(argv, linux=None):
 			sys.exit(1)
 	elif cli_args.subcommand == 'exec':
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
-
-		linux.create_kunitconfig(cli_args.build_dir)
-		linux.read_kunitconfig(cli_args.build_dir)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
 
 		exec_request = KunitExecRequest(cli_args.timeout,
 						cli_args.build_dir,
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index bda7c4fd4d3e..b2d71b1e85e4 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -129,28 +129,29 @@ def get_outfile_path(build_dir) -> str:
 class LinuxSourceTree(object):
 	"""Represents a Linux kernel source tree with KUnit tests."""
 
-	def __init__(self) -> None:
-		self._ops = LinuxSourceTreeOperations()
+	def __init__(self, build_dir: str, load_config=True, defconfig=DEFAULT_KUNITCONFIG_PATH) -> None:
 		signal.signal(signal.SIGINT, self.signal_handler)
 
-	def clean(self) -> bool:
-		try:
-			self._ops.make_mrproper()
-		except ConfigError as e:
-			logging.error(e)
-			return False
-		return True
+		self._ops = LinuxSourceTreeOperations()
+
+		if not load_config:
+			return
 
-	def create_kunitconfig(self, build_dir, defconfig=DEFAULT_KUNITCONFIG_PATH) -> None:
 		kunitconfig_path = get_kunitconfig_path(build_dir)
 		if not os.path.exists(kunitconfig_path):
 			shutil.copyfile(defconfig, kunitconfig_path)
 
-	def read_kunitconfig(self, build_dir) -> None:
-		kunitconfig_path = get_kunitconfig_path(build_dir)
 		self._kconfig = kunit_config.Kconfig()
 		self._kconfig.read_from_file(kunitconfig_path)
 
+	def clean(self) -> bool:
+		try:
+			self._ops.make_mrproper()
+		except ConfigError as e:
+			logging.error(e)
+			return False
+		return True
+
 	def validate_config(self, build_dir) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)
 		validated_kconfig = kunit_config.Kconfig()
-- 
2.29.2.684.gfbc64c5ab5-goog

