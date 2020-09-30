Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0549727F153
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgI3ScP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3ScO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:32:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD05C0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 11:32:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u35so2586437ybd.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=/2LbwaWNooOMKpnLJAJw9jcrrnwee0nQQaqBBLf78/Y=;
        b=b2Siq8d72wpXcNEVybG6qBGKlSWmEL42dSqiz9ouNhXXklc8D2RdftQoRCRXyX/MeE
         bZQgBzkyZ79eF8q3Tizg87UYoitBaPNfBYmsN2WIpcPDsBUhhg2v5aj3FBmJuVKuOsOG
         DnSvO28Pa4phSvpkJOCOgNDDeBwDztVoGrSxMfB9YY7ws/YZQc2BWP2/TTCQMIiSufLh
         I0++KeGrpb9RPNt5hs8cE9EbBnxep2qX3rZDxnTxJ3gAQx2WPrbwteopc8Drwt22pZa9
         dVFTKyMxhZ96Kfk6DbFmpDECSqWWS0EcetqedQDdH5UOCHHvvHlKlw4IVav8hvEzujo9
         5ilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc:content-transfer-encoding;
        bh=/2LbwaWNooOMKpnLJAJw9jcrrnwee0nQQaqBBLf78/Y=;
        b=Zuo1RhQYsv5PGwKc4Wn11F0KqYISYG2nyyI/UhsK2EEzE5WMAx7aJvq+EcQHElWb9D
         GoOat8eBLOSgNExcYJ3tgf9mh0grGWbSmVNBxefZkS+QobntcvJgoA8W6AOX4GDv5oQH
         5Zx0qT81ZR2IBt+8m18nJP/Efcaup8R+LNiEOmUb6xEgFxBWyA+8eWfjwGros20W2V2K
         PgQ7nNdnKiJr87oGtvAiKoPm5fIJnJrhkvjSSdTC6jBDdnWhrKKoRS3Z+POZh+zsSj1u
         90aATotbsecICePH8KlzdhNXVUf6ROiP6q3UzUO7VhO8PpWM++4KLOWrkKoFcQJj4dlH
         ZPAg==
X-Gm-Message-State: AOAM533xuvV/++kre5nwW09flgzi4l4kMQAQdhiLVGfApiD2OnlGoiWB
        KG2RRijeHtF7Lv7eLNDFG6T/9V9IGeEszA==
X-Google-Smtp-Source: ABdhPJxCZVQmy6aKg+oaaWzvBreZE/7lds9Y9QPeBscFiVG3hKr6AbO/lAHJKvJ8GuzJolIk6nMXTYJVn2IFFg==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:6805:: with SMTP id
 d5mr4814916ybc.4.1601490733625; Wed, 30 Sep 2020 11:32:13 -0700 (PDT)
Date:   Wed, 30 Sep 2020 11:31:51 -0700
Message-Id: <20200930183151.1046716-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH] kunit: tool: fix display of make errors
From:   Daniel Latypov <dlatypov@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CalledProcessError stores the output of the failed process as `bytes`,
not a `str`.

So when we log it on build error, the make output is all crammed into
one line with "\n" instead of actually printing new lines.

After this change, we get readable output with new lines, e.g.
>   CC      lib/kunit/kunit-example-test.o
> In file included from ../lib/kunit/test.c:9:
> ../include/kunit/test.h:22:1: error: unknown type name =E2=80=98invalid_t=
ype_that_causes_compile=E2=80=99
>    22 | invalid_type_that_causes_compile errors;
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> make[3]: *** [../scripts/Makefile.build:283: lib/kunit/test.o] Error 1

Secondly, trying to concat exceptions to strings will fail with
> TypeError: can only concatenate str (not "OSError") to str
so fix this with an explicit cast to str.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kuni=
t_kernel.py
index e20e2056cb38..0e19089f62f0 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -36,9 +36,9 @@ class LinuxSourceTreeOperations(object):
 		try:
 			subprocess.check_output(['make', 'mrproper'], stderr=3Dsubprocess.STDOU=
T)
 		except OSError as e:
-			raise ConfigError('Could not call make command: ' + e)
+			raise ConfigError('Could not call make command: ' + str(e))
 		except subprocess.CalledProcessError as e:
-			raise ConfigError(e.output)
+			raise ConfigError(e.output.decode())
=20
 	def make_olddefconfig(self, build_dir, make_options):
 		command =3D ['make', 'ARCH=3Dum', 'olddefconfig']
@@ -49,9 +49,9 @@ class LinuxSourceTreeOperations(object):
 		try:
 			subprocess.check_output(command, stderr=3Dsubprocess.STDOUT)
 		except OSError as e:
-			raise ConfigError('Could not call make command: ' + e)
+			raise ConfigError('Could not call make command: ' + str(e))
 		except subprocess.CalledProcessError as e:
-			raise ConfigError(e.output)
+			raise ConfigError(e.output.decode())
=20
 	def make_allyesconfig(self):
 		kunit_parser.print_with_timestamp(
@@ -79,9 +79,9 @@ class LinuxSourceTreeOperations(object):
 		try:
 			subprocess.check_output(command, stderr=3Dsubprocess.STDOUT)
 		except OSError as e:
-			raise BuildError('Could not call execute make: ' + e)
+			raise BuildError('Could not call execute make: ' + str(e))
 		except subprocess.CalledProcessError as e:
-			raise BuildError(e.output)
+			raise BuildError(e.output.decode())
=20
 	def linux_bin(self, params, timeout, build_dir, outfile):
 		"""Runs the Linux UML binary. Must be named 'linux'."""

base-commit: ccc1d052eff9f3cfe59d201263903fe1d46c79a5
--=20
2.28.0.709.gb0816b6eb0-goog

