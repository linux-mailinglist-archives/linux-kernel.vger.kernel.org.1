Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DA11A84CF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391576AbgDNQ1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391561AbgDNQ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:27:19 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC4DC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:27:18 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a201so14355406wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TAiqq1NiNVZMXD9DgwdiYOczrL2y/cITSCeKnTe7f9I=;
        b=RrtUuQiEg6SK9y6jfcdr9TviG7tU1TevvAVatYNNtHcxr+gypdwVn49V6FQoknHPav
         J4lEEgVSH+zFY+7RH/ubms87Vv/YCWOkx1oNY9abUTkZExK+9WrQrwp4GL1zvQJFlvye
         ISrWfxmihzC6WP8T4tyVuQx7gU0vCipY8hYAKsRLFiouVAHIGVdkLUrvY9ImX/kFh3Pt
         O3+lqz2GkkCycnIFyLGkpPkNeblZMWpEcL2KxQOT2ndomuVuhHckiWb/XkPHspzos67v
         awRBub2KhqfDCmhr3lONbU6l/IkK9Qyvn/n6lAaorQ+eKjWSt+zis+LOzJQeqI0BgmDy
         Sh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TAiqq1NiNVZMXD9DgwdiYOczrL2y/cITSCeKnTe7f9I=;
        b=J+s6yk4dIj0P+5hrqHPURvDC9upwQu4k+IjBx9IFEqKGw4ACKdDmcYYDfAodlwMNHi
         P2rAAdKtOGwbxVhaFn7or2UiJiapT8HSEtBZHs2xObqfnLQycJx7UJ6Q8ymyXXTo7AoB
         XpNz181vNMWgV/4/ITNZL7sDmS1m4yZ3ntWUE13NlDC/Odm304D8MuGhi6cpP4Yk0Ojy
         8vHVQMZO6gvbboazTH6Luap1i6YYZjSddDS0jUIPBCQu0kWRXr5ccWPt9XMPSlU8PjGp
         YiOhy7l7YWD757FMHpsCPKvuhnVggyqHSKDfrMG28KCOfqAqL2weFPAYQUyNlfXPEw3M
         OKxw==
X-Gm-Message-State: AGi0PuaXG7SdkvkfaJOc84eQLcnW49MlX/J8uKGLNpKju6enAk2eVnnx
        ZmCWT1iqscsHpI3ikRm4RWDLkA==
X-Google-Smtp-Source: APiQypLAVeugM/QwUY0JUXmfAjxmTt71cOvIWGqT/l5lRAgSy5srm6qFenW/P43papQ+isE0zGMSoA==
X-Received: by 2002:a05:600c:2314:: with SMTP id 20mr625566wmo.35.1586881637343;
        Tue, 14 Apr 2020 09:27:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id h5sm354636wrp.97.2020.04.14.09.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:27:16 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:27:13 +0100
From:   Quentin Perret <qperret@google.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        ctheegal@codeaurora.org, dianders@chromium.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        qais.yousef@arm.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] sched/core: Fix reset-on-fork from RT with uclamp
Message-ID: <20200414162713.GA256619@google.com>
References: <20200414161320.251897-1-qperret@google.com>
 <20200414162128.GA66453@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414162128.GA66453@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 Apr 2020 at 12:21:28 (-0400), Joel Fernandes wrote:
> Shouldn't this be conditional on p->sched_reset_on_fork instead of deleting
> the code?

Right, it's not obvious from the diff, but this code _is_ conditional on
p->sched_reset_on_fork already. This is what the whole function looks
like with my patch applied:

---8<---
static void uclamp_fork(struct task_struct *p)
{
        enum uclamp_id clamp_id;

        for_each_clamp_id(clamp_id)
                p->uclamp[clamp_id].active = false;

        if (likely(!p->sched_reset_on_fork))
                return;

        for_each_clamp_id(clamp_id) {
                unsigned int clamp_value = uclamp_none(clamp_id);

                uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
        }
}
--->8---

Thanks,
Quentin
