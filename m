Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5589425F7E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 12:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgIGKWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 06:22:23 -0400
Received: from foss.arm.com ([217.140.110.172]:59922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728658AbgIGKWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:22:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7337B106F;
        Mon,  7 Sep 2020 03:22:04 -0700 (PDT)
Received: from bogus (unknown [10.57.10.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B29C23F66E;
        Mon,  7 Sep 2020 03:22:02 -0700 (PDT)
Date:   Mon, 7 Sep 2020 11:22:00 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] cpufreq: arm_scmi: Constify scmi_perf_ops pointers
Message-ID: <20200907102200.GB17330@bogus>
References: <20200906230452.33410-1-rikard.falkeborn@gmail.com>
 <20200906230452.33410-2-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906230452.33410-2-rikard.falkeborn@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On Mon, Sep 07, 2020 at 01:04:50AM +0200, Rikard Falkeborn wrote:
> The perf_ops are not modified through this pointer. Make them const to
> indicate that. This is in preparation to make the scmi-ops pointers in
> scmi_handle const.
>

Your ack needed to take this as series via {arm-,}soc

-- 
Regards,
Sudeep
