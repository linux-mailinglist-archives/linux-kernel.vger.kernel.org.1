Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0001C21A6C8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 20:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgGISXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 14:23:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:28012 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgGISXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:23:02 -0400
IronPort-SDR: svkAobQIViVQNgoKoraa7xT5bSAoVREdKMuIWh8qY/jPlzjFu9cBhUusZxoTr17x/HEWbIIYfd
 PmOeTy1aOZHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="145567491"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="145567491"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 11:23:01 -0700
IronPort-SDR: uywKMzTJnQNrLrphuzdRFF2HqnX1nemVVTfCL8aPc8nGJMqml7JsPNIS6quMspsL1zSqg0gg/u
 jI14zpQXv38A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="458003100"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by orsmga005.jf.intel.com with ESMTP; 09 Jul 2020 11:22:58 -0700
Subject: Re: [PATCH 05/11] perf intel-pt: Use itrace error flags to suppress
 some errors
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20200709173628.5613-1-adrian.hunter@intel.com>
 <20200709173628.5613-6-adrian.hunter@intel.com>
 <20200709175046.GA1126680@tassilo.jf.intel.com>
 <3271e2cf-490b-5391-19e0-e1b019bfba1f@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3002ad3a-2ce1-3414-f511-f30370ec0488@intel.com>
Date:   Thu, 9 Jul 2020 21:22:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <3271e2cf-490b-5391-19e0-e1b019bfba1f@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/07/20 9:13 pm, Adrian Hunter wrote:
> On 9/07/20 8:50 pm, Andi Kleen wrote:
>> On Thu, Jul 09, 2020 at 08:36:22PM +0300, Adrian Hunter wrote:
>>> The itrace "e" option may be followed by a number which has the
>>> following effect for Intel PT:
>>> 	1	Suppress overflow events
>>> 	2	Suppress trace data lost events
>>> The values may be combined by bitwise OR'ing them.
>>>
>>> Suppressing those errors can be useful for testing and debugging
>>> because they are not due to decoding.
>>
>> I suspect it will be useful to more than just decoding and debugging.
>>
>> But the number is not a nice user interface.
>>
>> How about e[....] 
>>
>> like e[ol] 
> 
> Do you mean literally square-brackets? If you were really unlucky you might
> get pathname expansion with that.
> 
>>
>> Also it's a bit unusual that this disables instead of enables, but ok.

What about prefixing each flag with - i.e.

e-o
e-l
e-o-l

