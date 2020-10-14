Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909D928E5B8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgJNRtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:49:23 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2980 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726334AbgJNRtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:49:23 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 1813078D29AEC660D294;
        Wed, 14 Oct 2020 18:49:22 +0100 (IST)
Received: from [127.0.0.1] (10.210.170.149) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 14 Oct
 2020 18:49:20 +0100
Subject: Re: [PATCH] perf jevents: Fix event code for events referencing std
 arch events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <kjain@linux.ibm.com>, <irogers@google.com>,
        <yao.jin@linux.intel.com>, <yeyunfeng@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <=linux-arm-kernel@lists.infradead.org>
References: <1602170368-11892-1-git-send-email-john.garry@huawei.com>
 <20201012105430.GH1099489@krava>
 <5b0aefe2-e0d5-b5ff-654c-4e93c427050f@huawei.com>
 <20201012112419.GJ1099489@krava> <20201014164905.GN3100363@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <fa6351ab-4d2d-8de7-96e1-102d6fa0dd50@huawei.com>
Date:   Wed, 14 Oct 2020 18:46:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201014164905.GN3100363@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.149]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2020 17:49, Arnaldo Carvalho de Melo wrote:
> Ok, applied,

Thanks

>please consider adding a Fixes tag next time.
> 

Can do if it helps, but I only thought it appropriate when fixing 
something merged to mainline.

John
