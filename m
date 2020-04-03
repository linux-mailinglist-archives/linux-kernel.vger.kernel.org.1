Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F88C19DB73
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 18:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404253AbgDCQXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 12:23:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35788 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgDCQXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:23:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so6928214wrx.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 09:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=1gGWWeC2/OTnoDAZbJD9MrkCcGY0rWCnSshI7XLBK9s=;
        b=CoU0Gn3GhUUyoXblp3ViX6zxql2UAoZbEop/mUmzV98ectg7tucyl4x99VV1ltiuIR
         qvvBhII7aHD1Q8CQ1DqgvrQztNmwGO0/yA9lKXDu96apsF6T08YWUe/s6nH60fpTne5M
         Igyh7ZNMcHDsWJEc3Az8A/3rDyp2QDAYC7e4dDcyNMlQlFCejSHiZUAqUCjmKW7pduSp
         iN5b0+2cRJvvhkIB2C9C891axzLUO1zLbivONN8ELqgJj3cnB6NymLFs1GUgIiFdCMPo
         RDtJoFvImzbSdmvyT5+rIY3IHBxsm7+iW9IMAp6SKNB5FNx4P4lfmZbzs+m5gRqmuDb1
         rgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=1gGWWeC2/OTnoDAZbJD9MrkCcGY0rWCnSshI7XLBK9s=;
        b=lFHkS5tU5vJW8ViNR6vrkT4DD/mAcxQENq0mY2oKMddE/VL0pEI47sSaQr13iXIS7G
         zH3S1PSMcyvTSYpgTuTbZitBHxzw+9SYHlDlQtfJ4gQx76TK29CCrOF9kp8uOx0hkaVG
         ml5p/WULLC1T52p/FQbqTFD6NcVFmSkYRgx8XYYmdNpqd5bg5E0ba9NN1Stya54foPPV
         UeBtFNWg4je+toS35nb2gg8zAFim4UhDkAx+GfqKm+uoDyOiH9/Nuf4tR2aDXzAEXEqd
         pmhFhaAvMNjER9VRqhixsr29uFJSCo7UAyXnp34cXp3e1GFmpvF+zh3tjgsOU4glRqUq
         K5aA==
X-Gm-Message-State: AGi0PuYJrLs+otbe/eQR/o1G7x0Qu6I5BJYzI5Y+A8L/KkV+OCRpq6AI
        2LKAEmEQe6J7dn1SJx3qTQ==
X-Google-Smtp-Source: APiQypLZfMaVxV5Ta1pcCvzH/arF2VJiE3LWc/nWKn8c4lA/UJQ6EgXiQi5a4vB54vWSGNPRbIEhtw==
X-Received: by 2002:a5d:6187:: with SMTP id j7mr10285824wru.419.1585930986390;
        Fri, 03 Apr 2020 09:23:06 -0700 (PDT)
Received: from earth.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id x18sm12612461wrr.2.2020.04.03.09.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 09:23:05 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <djed@earth.lan>
Date:   Fri, 3 Apr 2020 17:23:04 +0100 (BST)
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Jules Irenge <jbi.octave@gmail.com>, julia.lawall@lip6.fr,
        boqun.feng@gmail.com, Jules Irenge <jbi.octave@example.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/10] sched/topology: Replace 1 and 0 by boolean value
In-Reply-To: <20200330112752.GJ20696@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LFD.2.21.2004031717230.10601@earth.lan>
References: <0/10> <20200327212358.5752-1-jbi.octave@gmail.com> <20200327212358.5752-3-jbi.octave@gmail.com> <20200330112752.GJ20696@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Mar 2020, Peter Zijlstra wrote:

> On Fri, Mar 27, 2020 at 09:23:49PM +0000, Jules Irenge wrote:
>> From: Jules Irenge <jbi.octave@example.com>
>>
>> Coccinelle reports a warning inside sched_energy_aware_handler()
>>
>> WARNING: Assignment of 0/1 to bool variable
>
> That's definitely not a warning and quite sensible in any case. Please
> learn C.

Thanks for the reply, I think I took the warning literally. I will take 
the advice any way.

Thanks,
Jules
