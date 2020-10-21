Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3CC295201
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 20:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503929AbgJUSJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 14:09:16 -0400
Received: from m12-13.163.com ([220.181.12.13]:57914 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503923AbgJUSJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 14:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=lbN6E
        bGWyekjo/lQzrzW5TfWRRLD2cGww5x6ixloWu4=; b=VnK2lJqwHUCn35qqlpVui
        DfW+144aDFY2tygjDg2SX/K0xrFHczcfsaizDHZuW5JjABaWBtHtwL6hKsFnjobC
        LaJrOokf7mhJcsW5rT7+1XASxAT2YNCw1t1caqviGUPZEOPAyF98+uSLPEdfMczF
        BIvtBmGg4kRR+MMpUzEcUo=
Received: from localhost (unknown [101.86.214.18])
        by smtp9 (Coremail) with SMTP id DcCowAAX5gJ0Q5Bfu7DGMQ--.29771S2;
        Wed, 21 Oct 2020 22:19:32 +0800 (CST)
Date:   Wed, 21 Oct 2020 22:19:32 +0800
From:   Hui Su <sh_def@163.com>
To:     David Riley <davidriley@chromium.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/time: access /sys/kernel/debug/udelay_test before
 test.
Message-ID: <20201021141932.GA138281@rlk>
References: <20201016180527.GA422291@rlk>
 <CAASgrz1FoQDz55m6F_raEYKoxX0GrUHif0Rm0DvWsR9WTqpBKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAASgrz1FoQDz55m6F_raEYKoxX0GrUHif0Rm0DvWsR9WTqpBKg@mail.gmail.com>
X-CM-TRANSID: DcCowAAX5gJ0Q5Bfu7DGMQ--.29771S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFy8ArWruFyrGF4fuw1xZrb_yoW5tr15pF
        W5XF4YyFWqgrnxCr1xtanruFnxZ3ykJ3WUA34Fvw1rur90v3Z8Jr17tryUWay8Xr4Sya40
        9w4qvFy3Kw1Sva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYfO7UUUUU=
X-Originating-IP: [101.86.214.18]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiMR3EX1UMWDD-HAAAsl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:27:05AM -0700, David Riley wrote:
> I don't think it's worth making debug_file_exist a separate function.  It's
> more clear to just do the check for the file, especially since you then log
> that path in the failure case.
> 
> On Fri, Oct 16, 2020 at 11:05 AM Hui Su <sh_def@163.com> wrote:
> 
> > before(when i did not compile udelay_test.ko):
> > sh@ubuntu:~/workspace/compile/tools/time$ sudo ./udelay_test.sh
> > ./udelay_test.sh: line 25: /sys/kernel/debug/udelay_test: Permission denied
> > ./udelay_test.sh: line 26: /sys/kernel/debug/udelay_test: No such file or
> > directory
> > ./udelay_test.sh: line 25: /sys/kernel/debug/udelay_test: Permission denied
> > ./udelay_test.sh: line 26: /sys/kernel/debug/udelay_test: No such file or
> > directory
> > ...
> > about two hundreds lines.
> >
> > we access '/sys/kernel/debug/udelay_test' the before starting the
> > udelay_test.
> >
> > now(when i did not compile udelay_test.ko):
> > sh@ubuntu:~/workspace/linux-stable/tools/time$ sudo ./udelay_test.sh
> > modprobe: FATAL: Module udelay_test not found in directory
> > /lib/modules/5.4.44
> > ERROR, can not access /sys/kernel/debug/udelay_test.
> > modprobe: FATAL: Module udelay_test not found.
> >
> > Signed-off-by: Hui Su <sh_def@163.com>
> > ---
> >  tools/time/udelay_test.sh | 51 +++++++++++++++++++++++++--------------
> >  1 file changed, 33 insertions(+), 18 deletions(-)
> >
> > diff --git a/tools/time/udelay_test.sh b/tools/time/udelay_test.sh
> > index 6779d7e55d85..853ba04e4149 100755
> > --- a/tools/time/udelay_test.sh
> > +++ b/tools/time/udelay_test.sh
> > @@ -12,10 +12,11 @@
> >
> >  MODULE_NAME=udelay_test
> >  UDELAY_PATH=/sys/kernel/debug/udelay_test
> > +retcode=0
> >
> >  setup()
> >  {
> > -       /sbin/modprobe -q $MODULE_NAME
> > +       /sbin/modprobe $MODULE_NAME
> >         tmp_file=`mktemp`
> >  }
> >
> > @@ -31,29 +32,43 @@ cleanup()
> >         if [ -f $tmp_file ]; then
> >                 rm $tmp_file
> >         fi
> > -       /sbin/modprobe -q -r $MODULE_NAME
> > +       /sbin/modprobe -r $MODULE_NAME
> > +}
> > +
> > +debug_file_exist()
> > +{
> > +       if [ ! -d "$UDELAY_PATH" ]; then
> > +               return 1
> > +       fi
> > +       return 0
> >  }
> >
> >  trap cleanup EXIT
> >  setup
> > +debug_file_exist
> >
> > -# Delay for a variety of times.
> > -# 1..200, 200..500 (by 10), 500..2000 (by 100)
> > -for (( delay = 1; delay < 200; delay += 1 )); do
> > -       test_one $delay
> > -done
> > -for (( delay = 200; delay < 500; delay += 10 )); do
> > -       test_one $delay
> > -done
> > -for (( delay = 500; delay <= 2000; delay += 100 )); do
> > -       test_one $delay
> > -done
> > -
> > -# Search for failures
> > -count=`grep -c FAIL $tmp_file`
> > -if [ $? -eq "0" ]; then
> > -       echo "ERROR: $count delays failed to delay long enough"
> > +if [ $? -eq 1 ]; then
> >         retcode=1
> > +       echo "ERROR, can not access $UDELAY_PATH."
> > +else
> > +       # Delay for a variety of times.
> > +       # 1..200, 200..500 (by 10), 500..2000 (by 100)
> > +       for (( delay = 1; delay < 200; delay += 1 )); do
> > +               test_one $delay
> > +       done
> > +       for (( delay = 200; delay < 500; delay += 10 )); do
> > +               test_one $delay
> > +       done
> > +       for (( delay = 500; delay <= 2000; delay += 100 )); do
> > +               test_one $delay
> > +       done
> > +
> > +       # Search for failures
> > +       count=`grep -c FAIL $tmp_file`
> > +       if [ $? -eq "0" ]; then
> > +               echo "ERROR: $count delays failed to delay long enough"
> > +               retcode=1
> > +       fi
> >  fi
> >
> >  exit $retcode
> > --
> > 2.25.1
> >
> >
> >

Yeah, i will send PATCH V2 after changing like you said.

