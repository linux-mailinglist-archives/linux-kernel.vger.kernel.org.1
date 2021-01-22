Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439FE300F92
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbhAVWEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730876AbhAVWAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:00:14 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06016C06178B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 13:59:23 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id l12so5702367ljc.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 13:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10zR+Da5IgJKyDEut9vatyUY62coO2MZOjRWuHR4NQc=;
        b=K/sIrGKNua7CS+pDc7Rg25lUeBFZxVGGXFVYonO67VjHPv/Fwmv2LfKFRuBm2NLtnt
         VAUJBiLqDkkkfM52N6mhXyEMKvN/4FY+3WM2M00S3QVcQNPRUHfGBueqqYxTckOHyPnO
         Z+lnjbz8naGv67+FX9YkAiYk7H8qBgUgCl7Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10zR+Da5IgJKyDEut9vatyUY62coO2MZOjRWuHR4NQc=;
        b=ZoASZXbxXeVruoJ6Sk5s53Qr+HxmMNfs5ok/wPilJZN6bDoftTzUNquVKv54zMpwgJ
         LAmFttc+R3FWlkeeSJd1mSGt5w5JwypFmxgr7ltcSCX8e2EXYYt2H/0cBgDqJM9tYtH8
         9r4h4x9KzxSpPN+qlUdqZjy1ggLIWmVDPb6+2TVfnXlTwUbeOz/CnXMf7YSZNbOMg2UO
         Tnkk/iB0/J+KfuX1saqaoGgfb1IfhMBRI4Zfm3ax+Y0m9phr+rhC3AleGds7wfKHvCJS
         VeADp6bnELE1xdiTT3gM2xD3Hf2Y4r8q34R/xoxAURiG6bfEDK0VABQS4bqFmMAq8hR/
         jwnQ==
X-Gm-Message-State: AOAM532QBAWyXsWxEfiyJWygbCES8L9TMhSPewHPIuxWLX2yxhUMV8SK
        JK6rj6IBXv/t8iD8zJumQghWJWB+0mBbhQ==
X-Google-Smtp-Source: ABdhPJzNbK5kemEqtyiOKsnMIY19CWObu1tF5ZAU+u57T5DUA8KYr6OkRLyJgfXZGhDEp3TGjlpN+g==
X-Received: by 2002:a2e:908e:: with SMTP id l14mr170864ljg.226.1611352760766;
        Fri, 22 Jan 2021 13:59:20 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id x69sm190323lff.226.2021.01.22.13.59.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 13:59:19 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id u25so9633384lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 13:59:19 -0800 (PST)
X-Received: by 2002:ac2:420a:: with SMTP id y10mr3048221lfh.377.1611352758767;
 Fri, 22 Jan 2021 13:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20210122135156.608434-1-acme@kernel.org>
In-Reply-To: <20210122135156.608434-1-acme@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Jan 2021 13:59:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjXjWWwOtGv22Edx+hv1od3g_eR+68J+bS93GiKqok15w@mail.gmail.com>
Message-ID: <CAHk-=wjXjWWwOtGv22Edx+hv1od3g_eR+68J+bS93GiKqok15w@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools fixes for v5.11, 2nd batch
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 5:52 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Test results in the signed tag at:

Side note: I'd actually prefer if you didn't do this. These big things
end up being (a hidden) part of the merge commit (and that's how the
tag verification works after-the-fact: ie I don't just verify the tag
when I pull, you can also do the verification later), and it really
makes zero sense to add 28kB of data to each merge just because you
hid them in the signed tag.

It would actually be better to have it just in the email at the end,
not in the tag.

Please?

              Linus
