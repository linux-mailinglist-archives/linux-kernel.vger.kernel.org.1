Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1C72FE2DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbhAUGaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbhAUG2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:28:55 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E767C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 22:28:15 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id by1so1064352ejc.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 22:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rwgvP8AoqgDSPVMCmPqHU4aJ92n1EnfAeIj2Yz3Gw3Q=;
        b=j/bL1BUg7wEjWJ2XEiCeKl5ZcKNAvNnxWb4MMMEdD5hOt51X0RghRJsnGZzz7W6s6o
         8fGVG7w9V5qTwUN2nIOaymNIO2vSHqLlJ8QFAb6P3iio2PJzO2rKW6UQO2f5mSFeKKFn
         kvQK+eS0BJtCrmt3U9sPtTggAwAtnXLtM9n716BJR2MzGyi5JZIwgXrnmUdQqCa9XsQm
         05/7Q54+iwwqqeJQ/aZ8Miz7feHb9hqv3j+7JOmIGH7E6B6+saD8W3dtsJ+29ewj160F
         C4cT+Z9ZVhY0hzNGiroOqdoIsoCvBleEJ/Dyi8YjqrT6WUgIwgOUzBY6PCC8frdh9ned
         N+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rwgvP8AoqgDSPVMCmPqHU4aJ92n1EnfAeIj2Yz3Gw3Q=;
        b=lYXDC3cL5vz5GNhfAn+aIRYVMqD9X1y5eSpNnxQ+35wdK+ZGEMrHgEQYENJOr3aiWQ
         aG9x4pjmw7Lta4zzY1JXrzbh8qwlrBcvS1X/A0ILTwHgsJ/PiBt3q7c2HOxdVYhdb5Hr
         LLI9otUjzMOwmzis7qjN/Dd9bMLY9A8j54iN/wK9sTBiWI1FDBxiRlUcqfjLF4A+FxG/
         QlgdEK6ZO2H1gnbkNKSfIE6wvCaG2KcocZGFUcaEImHAJG1QUiayesbwz+WmtPBel5/K
         wZshi/FQVQfUElBAKAWcIHt9ClBabh974QmqCfVnpKJUzvHb3JBrr66oPgohpIozs1gl
         PCbA==
X-Gm-Message-State: AOAM530pJwm4qYAsU7aBzEGFrGIX00JAgmmVv3Fv+yTBVcu5WElV3WdY
        uqSuM9V3vnCCR0kLly+v8PL9ypYtK8nQV+lgU9XAKA==
X-Google-Smtp-Source: ABdhPJyrVRb/FAVouTL2Re4ou3lIvSM3uEQTtZMyGaZXV+Wd0nJ3uq/TQmPAFTpawREd5KT4Aqg8GTONmAzC9HMMTHg=
X-Received: by 2002:a17:906:796:: with SMTP id l22mr8379890ejc.247.1611210493617;
 Wed, 20 Jan 2021 22:28:13 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 21 Jan 2021 11:58:02 +0530
Message-ID: <CA+G9fYso2u4Km7mG-PWC_G_BXZRK5qLNN+NK6ws4KmpSZKq4cw@mail.gmail.com>
Subject: test-definitions: kselftest upgrade to v5.10
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>, Tim.Bird@sony.com,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        Anmar Oueja <anmar.oueja@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you are not using the test-definitions project to run kselftest,
please ignore this email.

A new run script for kselftest, run_kselftest.sh [1], was created during the
Linux v5.10 release.

This script allows someone to run both individual test cases and sets of
test cases. Accordingly, the test-definitions kselftest script [2] was also
improved to support these upstream changes [1].  Currently this change is in
the test-definitions repository in a separate branch "kselftest". This has been
running in LKFT's CI since November 2020 [3].

The test-definitions kselftest script will stop supporting older versions of
the kselftest run script starting 1st-Feb-2021 from master branch.
OTOH, One have to use test-definitions Tag 2021.01 (will be created) for older
kselftest versions.

We request that any users of test-definitions project start updating your
kselftest sources to version v5.10 and above.

Upstream patch,
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/tools/testing/selftests/run_kselftest.sh?id=5da1918446a1d50d57f2f6062f7fdede0b052473
[2] https://github.com/Linaro/test-definitions/tree/kselftest/automated/linux/kselftest
[3] https://github.com/Linaro/test-definitions/tree/kselftest

---
From 5da1918446a1d50d57f2f6062f7fdede0b052473 Mon Sep 17 00:00:00 2001
From: Kees Cook <keescook@chromium.org>
Date: Mon, 28 Sep 2020 13:26:49 -0700
Subject: selftests/run_kselftest.sh: Make each test individually selectable

Currently with run_kselftest.sh there is no way to choose which test
we could run. All the tests listed in kselftest-list.txt are all run
every time. This patch enhanced the run_kselftest.sh to make the test
collections (or tests) individually selectable. e.g.:

$ ./run_kselftest.sh -c seccomp -t timers:posix_timers -t timers:nanosleep

Additionally adds a way to list all known tests with "-l", usage
with "-h", and perform a dry run without running tests with "-n".

Co-developed-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

--

- Naresh Kamboju
