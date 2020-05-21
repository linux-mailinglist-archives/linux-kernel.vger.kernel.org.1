Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAA21DD41B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 19:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgEURRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 13:17:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:13445 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728456AbgEURRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:17:51 -0400
IronPort-SDR: uxJmwEM2QAWaNvm9wyXYjGghzJ4K7j95e2ZaKBgqR2XAHwNH2tng1XT602pt4zAKy/y30nvL04
 Zz2OShO3QW0Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 10:17:50 -0700
IronPort-SDR: GcWwo029F+zhMQKXSnt859lu8SH4OQataP1SFcNCkiokDTsERhh6JTKZEvM5sNpN0Bi0R6mUDy
 UI6R0DszYwGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="254042885"
Received: from dsrao-mobl.amr.corp.intel.com (HELO [10.255.229.80]) ([10.255.229.80])
  by orsmga007.jf.intel.com with ESMTP; 21 May 2020 10:17:49 -0700
Subject: Re: [PATCH v3] ASoC: Intel: kbl_rt5663_rt5514_max98927: Split
 be_hw_params_fixup function
To:     =?UTF-8?Q?=c5=81ukasz_Majczak?= <lma@semihalf.com>
Cc:     alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        Ross Zwisler <zwisler@google.com>,
        linux-kernel@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bob Brandt <brndt@google.com>, Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@chromium.org>
References: <20200521162518.1809995-1-lma@semihalf.com>
 <3c89e614-81f5-ba87-19a9-fbe9f5c73925@linux.intel.com>
 <CAFJ_xbr8TN3ynfELJ3NQnkuRg0VRbkjB7=Cyb8yu2L==JGXJiw@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <475fb5c0-9b26-a8f6-c102-25c7775bc2ca@linux.intel.com>
Date:   Thu, 21 May 2020 12:17:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFJ_xbr8TN3ynfELJ3NQnkuRg0VRbkjB7=Cyb8yu2L==JGXJiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/20 12:08 PM, Łukasz Majczak wrote:
>>
>> don't add a new dailink, this is not right.
>>
> Can you advise a better solution how to assign different fixup
> functions to mic and to speakers? I was looking at "dmic01" dailink in
> skl_nau88l25_max98357a.c as an example.

I am not sure I follow. the DMICs are handled on a shared SSP, so how 
would one set a different fixup? The word length have to be the same.
