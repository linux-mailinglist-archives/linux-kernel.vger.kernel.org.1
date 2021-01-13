Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F3A2F5136
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbhAMRgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:36:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:42879 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbhAMRgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:36:10 -0500
IronPort-SDR: Ta2I8+QwwtMyWsyYRur4gfm08SVaHWt27eM8iFvsBSwxdtpiC7ZjzyAkq+a3NVDNbZXjob2A5v
 2TePSxmepBRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="175663409"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="175663409"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 09:35:30 -0800
IronPort-SDR: wJu4Syo0Vw4tAYF+99bLsCY7UAFz6aRI5AKSmDV/Gr01Rgn11uFb6X4YaQVC6qBsAc8jpSSg4m
 HM1ZvEYdk+vQ==
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="381939305"
Received: from iklein-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 09:35:27 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/1] docs: submitting-patches: Emphasise the requirement to Cc: stable when using Fixes: tag
In-Reply-To: <20210113171211.GF3975472@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210113163315.1331064-1-lee.jones@linaro.org> <87bldssrzu.fsf@intel.com> <20210113171211.GF3975472@dell>
Date:   Wed, 13 Jan 2021 19:35:24 +0200
Message-ID: <878s8wspsz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 13 Jan 2021, Jani Nikula wrote:
>
>> On Wed, 13 Jan 2021, Lee Jones <lee.jones@linaro.org> wrote:
>> > Clear-up any confusion surrounding the Fixes: tag with regards to the
>> > need to Cc: the stable mailing list when submitting stable patch
>> > candidates.
>> >
>> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Cc: Jonathan Corbet <corbet@lwn.net>
>> > Cc: linux-doc@vger.kernel.org
>> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> > ---
>> > v2:
>> >  - Link to the 'stable-kernel-rules' document as per Greg's request
>> >
>> >  Documentation/process/submitting-patches.rst | 5 +++++
>> >  1 file changed, 5 insertions(+)
>> >
>> > diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
>> > index 7c97ad580e7d0..7f48cccc75cdf 100644
>> > --- a/Documentation/process/submitting-patches.rst
>> > +++ b/Documentation/process/submitting-patches.rst
>> > @@ -556,6 +556,11 @@ which stable kernel versions should receive your fix. This is the preferred
>> >  method for indicating a bug fixed by the patch. See :ref:`describe_changes`
>> >  for more details.
>> >  
>> > +Note: Attaching a Fixes: tag does not subvert the stable kernel rules
>> > +process nor the requirement to Cc: stable@vger.kernel.org on all stable 
>> > +patch candidates. For more information, please read
>> > +:ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
>> 
>> Has there been a process change, or should I take it that a Fixes: tag
>> without Cc: stable *may* still end up being backported to stable?
>
> The 'process' has not changed.  Cc:ing the stable mailing list has
> been a requirement for years.  This patch clears up the misconception
> that you (and I ... and many others by all accounts) hold that the
> Fixes: tag is enough.
>
> Fixes: only works when/if Greg and/or Sasha run their magical scripts
> to scan for them.  By them doing so has "perpetuated a myth that this
> was the proper thing to do".  It's not.

I held no misconception here, and we've scripted adding appropriate Cc:
stable for years along with the Fixes: tag.

There's been debate in the past whether commits with *only* Fixes:
should be automatically backported with the magic scripts at all. I
don't mean to reopen that question now, but that was what I was
referring to with the process change.

BR,
Jani.

>
> Greg got fed-up of people asking that same question, so I'm fixing
> that and giving him something to point to and say "RTFD".
>
> Hope that clears things up.

-- 
Jani Nikula, Intel Open Source Graphics Center
