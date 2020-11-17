Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3B12B6C70
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgKQSAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:00:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:40169 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729214AbgKQSAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:00:47 -0500
IronPort-SDR: iKsB46VUAJxNlm7M2nJmnKf4orldiDl4Q+Rok2aJMxWycMnuQY4jvLOvkFdn6BfnL48fmPFRIw
 AC6ogr9TWhsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="170193627"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="170193627"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 10:00:43 -0800
IronPort-SDR: B8bcZFL873mO5FRWvxRTsIGGke6aZyIbmFQJTv4wpk0B2JexGxN8q0Hb9ZkARnhv02/XUddHzm
 dVWg/53D2Diw==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="476009881"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.148.85]) ([10.249.148.85])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 10:00:38 -0800
Subject: Re: [PATCH v4] Add power/gpu_frequency tracepoint.
To:     Steven Rostedt <rostedt@goodmis.org>, Peiyong Lin <lpy@google.com>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        android-kernel@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pavel Machek <pavel@ucw.cz>,
        Prahlad Kilambi <prahladk@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        zzyiwei@android.com, Sidath Senanayake <sidaths@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20200820162738.33053904@oasis.local.home>
 <20201022173434.910879-1-lpy@google.com>
 <CA+0soAkD7BG6CjhMW6PYR4yAgDykU2uUizcHx1QQdXqgesCFFg@mail.gmail.com>
 <20201116160508.3e86496f@gandalf.local.home>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <173158b7-e65e-257f-0e24-aa9d5401d1d1@intel.com>
Date:   Tue, 17 Nov 2020 19:00:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201116160508.3e86496f@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/2020 10:05 PM, Steven Rostedt wrote:
> On Mon, 16 Nov 2020 12:55:29 -0800
> Peiyong Lin <lpy@google.com> wrote:
>
>> Hi there,
>>
>> May I ask whether the merge window has passed? If so is it possible to
>> ask for a review?
> This is up to the maintainers of power management to accept this.
>
> Rafael?

I'd say up to the GPU people rather (dri-devel CCed) since that's where 
it is going to be used.

Also it would be good to see at least one in-the-tree user of this (or a 
usage example at least).

Cheers!


