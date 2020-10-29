Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D69229E9C0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgJ2Kz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:55:56 -0400
Received: from foss.arm.com ([217.140.110.172]:60384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgJ2Kz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:55:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30E0213A1;
        Thu, 29 Oct 2020 03:55:55 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D6B13F66E;
        Thu, 29 Oct 2020 03:55:45 -0700 (PDT)
Subject: Re: [PATCH v5 06/21] perf arm-spe: Refactor printing string to buffer
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
 <20201029071927.9308-7-leo.yan@linaro.org>
 <cbb23f8e-b534-fffa-4dfe-a496fd3f6bef@arm.com>
 <20201029105159.GG16862@leoy-ThinkPad-X240s>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <f6a3df74-edc5-6a0e-dc36-7c1efaf55ffc@arm.com>
Date:   Thu, 29 Oct 2020 10:54:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201029105159.GG16862@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2020 10:51, Leo Yan wrote:
> Hi Andre,
> 
> On Thu, Oct 29, 2020 at 10:23:39AM +0000, Andrï¿½ Przywara wrote:
> 
> [...]
> 
>>> +static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
>>> +				const char *fmt, ...)
>>> +{
>>> +	va_list ap;
>>> +	int ret;
>>> +
>>> +	va_start(ap, fmt);
>>> +	ret = vsnprintf(*buf_p, *blen, fmt, ap);
>>> +	va_end(ap);
>>> +
>>> +	if (ret < 0) {
>>> +		if (err && !*err)
>>> +			*err = ret;
>>> +	} else {
>>> +		*buf_p += ret;
>>> +		*blen -= ret;
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>
>> So this now implements the old behaviour of ignoring previous errors, in
>> all cases, since we don't check for errors and bail out in the callers.
>>
>> If you simply check for validity of err and for it being 0 before
>> proceeding with the va_start() above, this should be fixed.
> 
> I think you are suggesting below code, could you take a look for it
> before I proceed to respin new patch?>
> static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
> 				const char *fmt, ...)
> {
> 	va_list ap;
> 	int ret;
> 
>         /* Bail out if any error occurred */
>         if (err && *err)
>                 return *err;
> 
> 	va_start(ap, fmt);
> 	ret = vsnprintf(*buf_p, *blen, fmt, ap);
> 	va_end(ap);
> 
> 	if (ret < 0) {
> 		if (err && !*err)
> 			*err = ret;
> 	} else {
> 		*buf_p += ret;
> 		*blen -= ret;
> 	}
> 
> 	return ret;
> }

Yes, this is what I had in mind.

Cheers,
Andre
