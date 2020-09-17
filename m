Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA14526D9CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgIQLEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIQLAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:00:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC58C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:00:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d9so993055pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HgzwSyCKKLf4qD/4NKqd5WMkMMq1Xoo1+QGWfkY+Z8k=;
        b=Lnwc//+zYgv01F6ATSNmEBvPwfpGzZYhXCnL3LnezmqnG/MEc0ilUAWqhoMcVD7OkQ
         j5qvk9ABadIZpl9+J5ebm35H97iBADCAuWuccrYn7sVScfqv5boA3XoiKC5w5NBgmaIz
         i+SkiayNw2NzxZ2aQHiJ9dTPWPwexo6rnbIbA5hmXG1wsWUbZOman/x4SKgqE+6wHaAF
         1GVsRZUY9co3S77thjgiGEJHWIBK2X10qXOdb5dBss0Lb0n3QGb/PrDJjxK8JyxLNLhX
         Yvq9F2SMxKAr9qh5/Pxq2LFMQyuRlK+ExIo3AoY+F3SZ5R8VqCdIdYq6jIwmOFr4+vJA
         I39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HgzwSyCKKLf4qD/4NKqd5WMkMMq1Xoo1+QGWfkY+Z8k=;
        b=F+hndVkvek2CRK3LvRGayuYll7JsvG0TL7nJvwe7ElgqpLlUH0Swm5E9uWlcAeEZg/
         NtWFP4lWMhjia6xR0xVSPis6FcxH0/odFnPuN4Iw2XzRRDA0uyTzHlSo6lSB5ZF57aB4
         x9xGXiGkG4h+M8UgKmta1B57Q7SKCPI86PqAum17XyxevbuXTaBQ5hY8pNIfUlnxjfJO
         /U//F35hb40+zvn+aTfIbtUziSfWoQXxq/ph+bptSdNsl+jfMWCqxufyYHFKZCkpfVpH
         fcRWFSIYwdFB5RbPAcwRBG3EMnxLHktNwd+dIutY1Qpt+OXLf5c7jZiedDCaiRgFI8f9
         HsYQ==
X-Gm-Message-State: AOAM531XtmDK5X8pkY6kb2ZXCOvU+sAfk4DbRIyHlUN0FBaItxLJP/5J
        qWGRbncdGzoN6BAhNlREwtA=
X-Google-Smtp-Source: ABdhPJwRA/dhSuBajZpU2if3GKD//1RBOuQmfoaAL0Fd6dQpgD+slpeeyVZSkcdxTKvYCWZWSQ7DEw==
X-Received: by 2002:a63:6fc6:: with SMTP id k189mr21465070pgc.165.1600340432684;
        Thu, 17 Sep 2020 04:00:32 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id m188sm21160330pfd.56.2020.09.17.04.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 04:00:31 -0700 (PDT)
Date:   Thu, 17 Sep 2020 20:00:28 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Leo Yan <leo.yan@linaro.org>, Marc Zyngier <maz@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv3] perf kvm: add kvm-stat for arm64
Message-ID: <20200917110028.GB3049@jagdpanzerIV.localdomain>
References: <20200917003645.689665-1-sergey.senozhatsky@gmail.com>
 <20200917100950.GC12548@leoy-ThinkPad-X240s>
 <20200917101219.GD12548@leoy-ThinkPad-X240s>
 <652f10660f09bd608b825233713f775a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <652f10660f09bd608b825233713f775a@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/17 11:21), Marc Zyngier wrote:
> > > On Arm64, ftrace tracepoint "kvm_entry" doesn't contain the field "id"
> > > or field "vcpu_id", thus it always reads out the "id" is 0 and it is

Right, Leo, I saw that. I put "id", because there is ... well, there is
nothing we can put there. The trace points on arm64, unlike on s390 or x86,
don't contain info which can let us map trace-event to vcpu_id (even
(void *)vcpu would have been rather helpful).

> > > Essentially, this issue is caused by different archs using different
> > > format for ftrace event "kvm_entry", on x86 it contains feild
> > > "vcpu_id" but arm64 only just records "vcpu_pc".

Exactly. I wish trace-points were less of pain-points.

So 'perf kvm stat' on arm64 works, but it's not as feature rich as on other
platforms; at the same it's better than nothing, I suppose.

	-ss
