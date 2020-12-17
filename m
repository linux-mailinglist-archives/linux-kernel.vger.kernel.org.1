Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CDA2DDACE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 22:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgLQV0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 16:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbgLQV0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 16:26:16 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BF5C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 13:25:36 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id z12so128940pjn.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 13:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cKNE4Ll3LbqQqi/vsSSnD8gv0zzuQpoyh0gLWN6xhD0=;
        b=eoOVXWFoeqY4b6J7GsYROACiZ6V+ENVkYs79nY5OlPO/qxefEC6xaFwDcXLpfk9ywG
         LIpolf5jYqYUOxO8lM8Sx44hI+BewEGql7609u0yxyKqwOOxLBFatd/7KDNq8HBSQB74
         uBvMRx1KFhx/4w7a8iebx00wUf35+sLx0HW9xtwaDGfG/znI3emStmIYPrBsQfhca7Jr
         GJNWfbysMeMmfYi0j1JhcBxf04qonRI3mc9BTMIuAikpdtCDXTVDK9q6L+VUvnWSvwS7
         g6j+iF3tjhPomCgzcGXlMtiE+lBATNu5i6AxNxY8hUiqES16nvKPk1NMA+8nb+ZWm1Gy
         6WGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=cKNE4Ll3LbqQqi/vsSSnD8gv0zzuQpoyh0gLWN6xhD0=;
        b=ffroZ+gmhLe69ybI9R3eM7WG1psT3PXHqS0k7LTdKAeqEnve6qop2OJ1c8QLfibIEf
         1wul8HxVi+e9SjWalNEnW06IHZXsEV7/CTu2AHvmiF/0ENpdI2mIPFmdITMkAVS7So+M
         vbJQ7/3UzmJZiX+QotbXNgPm9NvA41pWXHRC6mUS8cK4vzAeVqNEeOA0Hg6VAkExLMe5
         EUbKa+v+bKHL54rArckUjvF1PzfieVToMw6I5A9ERk8Zn7XP+xYysEfZ8r5mUfAlX7tl
         ECYM+ogykTrgnN22WycC6jm2GRoNINES/AFLXqCA/iYhc5r7oXVhLwbJNrhgQGT0C6Sa
         EzcA==
X-Gm-Message-State: AOAM533xAis5KGGaLTsGFgNUr4iJGc0XMKkRdc7Z13n5dAF0bFdfRegh
        FacEuu9EB+I8YW4YE5NiS8AQmg==
X-Google-Smtp-Source: ABdhPJz6EsiB3cJ4HZ3oGGLUDn55HprsHHoFuQFNAlqyX0+nruQAzzscAtJC0z/ygi0mm7YuAWXYiw==
X-Received: by 2002:a17:902:8498:b029:d8:e2a0:e4e7 with SMTP id c24-20020a1709028498b02900d8e2a0e4e7mr835859plo.49.1608240335511;
        Thu, 17 Dec 2020 13:25:35 -0800 (PST)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id a141sm6893211pfa.189.2020.12.17.13.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 13:25:34 -0800 (PST)
From:   Benjamin Segall <bsegall@google.com>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, mgorman@suse.de, mingo@redhat.com,
        pauld@redhead.com, peterz@infradead.org, pjt@google.com,
        rostedt@goodmis.org, vincent.guittot@linaro.org,
        khlebnikov@yandex-team.ru, xiyou.wangcong@gmail.com,
        shanpeic@linux.alibaba.com
Subject: Re: [PATCH 0/4] sched/fair: Burstable CFS bandwidth controller
References: <20201217074620.58338-1-changhuaixin@linux.alibaba.com>
Date:   Thu, 17 Dec 2020 13:25:31 -0800
In-Reply-To: <20201217074620.58338-1-changhuaixin@linux.alibaba.com> (Huaixin
        Chang's message of "Thu, 17 Dec 2020 15:46:16 +0800")
Message-ID: <xm26zh2cxgz8.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code for this looks fine, and the feature is something people do
seem to ask for occasionally. I agree with peterz that using this
generally means you lose any guarantees (which are already imperfect
given CFS), but I suspect that cfsb is being used in overload anyways.

The docs could use a grammar/wording pass maybe, but that's easy enough.
