Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF372888B4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733133AbgJIMaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:30:01 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:33593 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgJIM34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:29:56 -0400
Received: by mail-ej1-f47.google.com with SMTP id c22so12843643ejx.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 05:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DPh0rxFchA8X3XcbIpxU3iLODV5fxJXPKEUaVKZJepE=;
        b=Bupsv5KAcbMd1A7YDYZ+Fl5lbGI+gSyfAsqMfgPT0SOVUi0cGwashal/SMiawlhJET
         JT/GmT8sc5uBKf+L+FaDmktX2JLqVBbjweyY6rrSlWR2CHzamAgM+Cexg2LlzNXMn8p2
         OTIyJ2yU2YHYnxDQBmrRi0SZnE4x9bsZ1LHkhxa63IwTnCtwUiBtAQRdPmIoBKKQXY1U
         0VAxw20hiExrUIn29p0gC+2axpbrAdmsHz8unaWLVaJdkXJ1TOEcj05Ogb4hTy6IAoZw
         vgl8TVYQgf0tHVtR9yI2TFincu1eFf5jV6ADbsHIFfnEzH+Ha1YYVR0LlTx8kiUhJ1MS
         tmNA==
X-Gm-Message-State: AOAM5335Z9EIzlsteV+Z2fF329CDTM366DydX4USnpoGrKbDIszwVbOl
        tOeBahZm8/rbsOXxQn5qQ1oAS7+Btq8=
X-Google-Smtp-Source: ABdhPJwhCW2CEFtXl6643odMVwmmMD8h81HcSw/ctaiOXiXTm0tl15mHUUl/XXg/j6bIz3Jp7/gieQ==
X-Received: by 2002:a17:906:770c:: with SMTP id q12mr13680243ejm.518.1602246594410;
        Fri, 09 Oct 2020 05:29:54 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-85-160-42-169.eurotel.cz. [85.160.42.169])
        by smtp.gmail.com with ESMTPSA id q27sm6412701ejd.74.2020.10.09.05.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 05:29:53 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 0/5] allow overriding default preempt mode from command line
Date:   Fri,  9 Oct 2020 14:29:21 +0200
Message-Id: <20201009122926.29962-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007120401.11200-1-mhocko@kernel.org>
References: <20201007120401.11200-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
let me repost the pile that has grown from the initial patch based on
the review feedback I have collected from Peter. I do realize that he
also suggested to go from the other direction and implement this for the
full preemption mode first. As I've said I believe this would require to
examine all CONFIG_PREEMPTION code paths and preempt_mode=[none,voluntary]
is already quite useful for distributions which are targeting high
throuhput and desktop environments. Adding full preemption on top is
definitely desirable and something we will be looking into. This is the
first step in that direction.

If maintainers really believe that starting from the full preemption
mode first then we are willing to explore that path of course.

I am stil posting that as an RFC because I didn't get to push this
through a complete compile time testing and rely on 0-day bot in that
aspect.

Thanks and I am looking forward for a further feedback.


