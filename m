Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CA428F60E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbgJOPpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:45:33 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2982 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730951AbgJOPpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:45:32 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 1224F3D98AB4C5434A15;
        Thu, 15 Oct 2020 16:45:31 +0100 (IST)
Received: from [127.0.0.1] (10.47.3.72) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 15 Oct
 2020 16:45:29 +0100
Subject: Re: [PATCH] perf jevents: Fix event code for events referencing std
 arch events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@redhat.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <kjain@linux.ibm.com>, <irogers@google.com>,
        <yao.jin@linux.intel.com>, <yeyunfeng@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1602170368-11892-1-git-send-email-john.garry@huawei.com>
 <20201012105430.GH1099489@krava>
 <5b0aefe2-e0d5-b5ff-654c-4e93c427050f@huawei.com>
 <20201012112419.GJ1099489@krava> <20201014164905.GN3100363@kernel.org>
 <fa6351ab-4d2d-8de7-96e1-102d6fa0dd50@huawei.com>
 <20201015122522.GA2896742@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1ea95471-2ea6-8931-1074-787210722a88@huawei.com>
Date:   Thu, 15 Oct 2020 16:42:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201015122522.GA2896742@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.3.72]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I decided not to do any rebase on perf/core, so those Fixes will remain
> valid.

Ah, ok. Then that should be fine wrt fixes tags.

Cheers,
John
