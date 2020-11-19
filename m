Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F0D2B9419
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgKSOIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:08:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41625 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgKSOIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:08:13 -0500
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1kfkba-0007BY-H3
        for linux-kernel@vger.kernel.org; Thu, 19 Nov 2020 14:08:10 +0000
Received: by mail-ej1-f71.google.com with SMTP id j18so682715ejs.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 06:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+pQI3vl7MWJqgPLAwywjvM8WWJx1RapH5cmUPMx6aU=;
        b=rjoVAI0nNe4WWwl00CfVEOzyge6r09xiHcuIESTNynT+ttVrv3PaAIjTCAOoQ0PPVe
         9DU1sPlwT4m5fgW8u9wW4/DlUF+LkxwPqVMiLgGbeqLzHjeuGgIxx3KBqqQp7B17q8dt
         wfJuA+gR9H+ifd/SQvzuh/4PKd19HSv0+4Uxbr9elS1tkksu7N3exZ0zZ3HbualDd4fu
         SLbRcqA8ocmHqEHZEwnRGNt0UVd8pTDoRTSyVtiSFGjInedq6ZBH2a+ruoTN9VtqEiQG
         P85HqI9NHajM/cMD25Z2EKH7Jf+7wk02g+c0fWAtjqt6n+75eAwCexIUTc2H1tWCregn
         Xhlw==
X-Gm-Message-State: AOAM530UI4AY49Ah4m+K/GxfH3MWy1fhXL+KsLNazA4d0GEI2V+hf0Rb
        tHl9h0vKf8F3owdwhYw5hSZNlAAHuTxoCOjJlRCm67DZG8AggU8/WfGkP4plUeCXruMNoj3HQDm
        zb2f6o1RyhQYeJXEXTarVK0kBcORLfEQVURY66urajMlv/GUhr7a+0LPTAA==
X-Received: by 2002:aa7:d298:: with SMTP id w24mr6122153edq.82.1605794890266;
        Thu, 19 Nov 2020 06:08:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhOyXhhKlZ1fwP9pcGwN0YH59LtZfO6NjPKkXh/FKc3qHoKSXt9FJCq2QZls2j4A2BlKV2fgreh08s8mqGRAU=
X-Received: by 2002:aa7:d298:: with SMTP id w24mr6122126edq.82.1605794890082;
 Thu, 19 Nov 2020 06:08:10 -0800 (PST)
MIME-Version: 1.0
References: <17fc60a3-cc50-7cff-eb46-904c2f0c416e@canonical.com>
 <20201118235015.GB6015@geo.homenetwork> <20201119003319.GA6805@geo.homenetwork>
 <CAKfTPtBYm8UtBBnbc7qddA2_OAa3vwH=KoHNgvsQJ9zO2KocYQ@mail.gmail.com>
 <7c9462c9-8908-8592-0727-9117d4173724@canonical.com> <CAKfTPtAfzxbm0qM+8r2i+3jWjpJ2OLbU4F1WE8GrzTZH6Ck7FA@mail.gmail.com>
In-Reply-To: <CAKfTPtAfzxbm0qM+8r2i+3jWjpJ2OLbU4F1WE8GrzTZH6Ck7FA@mail.gmail.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Thu, 19 Nov 2020 11:07:34 -0300
Message-ID: <CAHD1Q_xNgdAD59UnJmA4xHgwVcoNVTUkG1x_KfCuTVkc1SE9Aw@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: fix unthrottle_cfs_rq for leaf_cfs_rq list
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Tao Zhou <t1zhou@163.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        SeongJae Park <sjpark@amazon.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tao Zhou <zohooouoto@zoho.com.cn>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Tao Zhou <ouwen210@hotmail.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Gavin Guo <gavin.guo@canonical.com>,
        "Heitor R. Alves de Siqueira" <halves@canonical.com>,
        Nivedita Singhvi <nivedita.singhvi@canonical.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "# v4 . 16+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Vincent, much appreciated! I'll respond in the patch thread,
hopefully we can get that included in 5.4.y .

Cheers,


Guilherme
