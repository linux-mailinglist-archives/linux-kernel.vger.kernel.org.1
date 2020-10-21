Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343772950A1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444539AbgJUQVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444530AbgJUQVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:21:55 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FF5C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:21:55 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id f10so2357703otb.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UddkOGHhdOnx8gO073FR4GFAl/3VCv5YzyVjZQV2kTY=;
        b=RIn4Zs4JYb0ISiXDMhZlmVBOs1H92Pt/XfcOik/Zg/T/AiT59oDR6E6T5SDcjzTyRs
         eAWYWSM4i+f7uWB7VRuSCm9Jrdq296pt5JTJS922HYjL88+A46XjTj3fpTl38Ep3XlBL
         04L1LlzfVPY85rukqCmQ94emlE4UB9GxAGhkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UddkOGHhdOnx8gO073FR4GFAl/3VCv5YzyVjZQV2kTY=;
        b=UhBUqziQiiMQDWsuX05uJYKPIJCEaPunJU9VQ6lcWOytVX5QlhGbk/h1nlgVH8mAjT
         UTENJLu3lOjYAFtd/0KjddGwuy7irLEt++OSKBw0ocFXY1+/O8MBOFTAWMciIzTZPy4s
         7tNuGuLXh13QRPDobEQR7QTLR5PGCQ8/p3pM86UuOZtrqS3vUjSTFr/wulANzZx37Akz
         TbgZJVYjz/qIZ7bYDFgZXHS3UJvWn/9LGiehAQhAOk2CdX1WUTNE0TrVJYiAoUaFX9RL
         k5WlV6WNtK3Zkr03cXPX6kEm50u8+E6+GrOcoHSDWDfo8pC6JTN3IvnyboxRnSxWF62T
         ecJg==
X-Gm-Message-State: AOAM533PMSGU9QpNN5tfDnybjHWj23r+6yd3HxpSYDe5pPL5AxDiQKTa
        Q2HsEb5uXH1b8Y3NxO1Gn7Sy3JcEdSYRzDbs6kS/WY2EjeE=
X-Google-Smtp-Source: ABdhPJyhDSe/eiZWRQHoq2OJ75BzNcjQUtJNhB808EgRv7a7Ztp1KxflWeSaTmjVrkIq6HE7s9hSEQtv61z3NhA52us=
X-Received: by 2002:a05:6830:4033:: with SMTP id i19mr3357774ots.127.1603297314353;
 Wed, 21 Oct 2020 09:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201021150458.GA139977@rlk>
In-Reply-To: <20201021150458.GA139977@rlk>
From:   David Riley <davidriley@chromium.org>
Date:   Wed, 21 Oct 2020 09:21:43 -0700
Message-ID: <CAASgrz2ZMBubM6Q8C0MD=TcCqAS62j_W4JQ4PzPjYEc3Mb6VaQ@mail.gmail.com>
Subject: Re: [PATCH v2] tools/time: access /sys/kernel/debug/udelay_test
 before test
To:     Hui Su <sh_def@163.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: David Riley <davidriley@chromium.org>

On Wed, Oct 21, 2020 at 8:05 AM Hui Su <sh_def@163.com> wrote:
>
> before(when i did not compile udelay_test.ko):
> sh@ubuntu:~/workspace/compile/tools/time$ sudo ./udelay_test.sh
> ./udelay_test.sh: line 25: /sys/kernel/debug/udelay_test: Permission denied
> ./udelay_test.sh: line 26: /sys/kernel/debug/udelay_test: No such file or directory
> ./udelay_test.sh: line 25: /sys/kernel/debug/udelay_test: Permission denied
> ./udelay_test.sh: line 26: /sys/kernel/debug/udelay_test: No such file or directory
> ...
> about two hundreds lines.
>
> we access '/sys/kernel/debug/udelay_test' the before starting the
> udelay_test.
>
> now(when i did not compile udelay_test.ko):
> sh@ubuntu:~/workspace/linux-stable/tools/time$ sudo ./udelay_test.sh
> modprobe: FATAL: Module udelay_test not found in directory /lib/modules/5.4.44
> ERROR, can not access /sys/kernel/debug/udelay_test.
> modprobe: FATAL: Module udelay_test not found.
>
> ---
> v1->v2: remove the debug_file_exist().
>
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  tools/time/udelay_test.sh | 42 ++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
>
> diff --git a/tools/time/udelay_test.sh b/tools/time/udelay_test.sh
> index 6779d7e55d85..c8458d5b7fcd 100755
> --- a/tools/time/udelay_test.sh
> +++ b/tools/time/udelay_test.sh
> @@ -12,10 +12,11 @@
>
>  MODULE_NAME=udelay_test
>  UDELAY_PATH=/sys/kernel/debug/udelay_test
> +retcode=0
>
>  setup()
>  {
> -       /sbin/modprobe -q $MODULE_NAME
> +       /sbin/modprobe $MODULE_NAME
>         tmp_file=`mktemp`
>  }
>
> @@ -31,29 +32,34 @@ cleanup()
>         if [ -f $tmp_file ]; then
>                 rm $tmp_file
>         fi
> -       /sbin/modprobe -q -r $MODULE_NAME
> +       /sbin/modprobe -r $MODULE_NAME
>  }
>
>  trap cleanup EXIT
>  setup
>
> -# Delay for a variety of times.
> -# 1..200, 200..500 (by 10), 500..2000 (by 100)
> -for (( delay = 1; delay < 200; delay += 1 )); do
> -       test_one $delay
> -done
> -for (( delay = 200; delay < 500; delay += 10 )); do
> -       test_one $delay
> -done
> -for (( delay = 500; delay <= 2000; delay += 100 )); do
> -       test_one $delay
> -done
> -
> -# Search for failures
> -count=`grep -c FAIL $tmp_file`
> -if [ $? -eq "0" ]; then
> -       echo "ERROR: $count delays failed to delay long enough"
> +if [ ! -d "$UDELAY_PATH" ]; then
>         retcode=1
> +       echo "ERROR, can not access $UDELAY_PATH."
> +else
> +       # Delay for a variety of times.
> +       # 1..200, 200..500 (by 10), 500..2000 (by 100)
> +       for (( delay = 1; delay < 200; delay += 1 )); do
> +               test_one $delay
> +       done
> +       for (( delay = 200; delay < 500; delay += 10 )); do
> +               test_one $delay
> +       done
> +       for (( delay = 500; delay <= 2000; delay += 100 )); do
> +               test_one $delay
> +       done
> +
> +       # Search for failures
> +       count=`grep -c FAIL $tmp_file`
> +       if [ $? -eq "0" ]; then
> +               echo "ERROR: $count delays failed to delay long enough"
> +               retcode=1
> +       fi
>  fi
>
>  exit $retcode
> --
> 2.25.1
>
>
