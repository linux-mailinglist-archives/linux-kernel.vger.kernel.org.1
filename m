Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C509429049A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 14:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407135AbgJPMCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 08:02:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:35946 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407059AbgJPMCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:02:33 -0400
IronPort-SDR: wxj8eKn4Opm6LZ2yzSBM4WwFiF4FphkMzKvrWwVmgwjOQvQnKPsXU9ugnuN0fungufyO1lPcsY
 meaBz1w1N4YQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="154392405"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="154392405"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 05:02:31 -0700
IronPort-SDR: gIZfrsiE3LfGnWrpXs0G8b+34uHblssbdGNAZBUx8I5HlwvIXIPCMF2rqgzPrMrnmw6d5yLoyE
 iaCFJiuD47Jg==
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="531691310"
Received: from wpross-mobl1.ger.corp.intel.com (HELO [10.249.36.186]) ([10.249.36.186])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 05:02:28 -0700
Subject: Re: [PATCH v6 44/80] docs: gpu: i915.rst: Fix several C duplication
 warnings
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
 <52a0dd42d3730d35b3ecd00d20a0601793e443e6.1602589096.git.mchehab+huawei@kernel.org>
 <160284606673.11659.11178759979047002902@jlahtine-mobl.ger.corp.intel.com>
 <20201016133724.1d578006@coco.lan>
 <8dce8bc0-c83b-c256-aa35-229d4d583f74@intel.com> <87v9fa9yq9.fsf@intel.com>
From:   Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Organization: Intel Corporation (UK) Ltd. - Co. Reg. #1134945 - Pipers Way,
 Swindon SN3 1RJ
Message-ID: <612ce5c4-ce6d-5342-213f-6cb3e2c7135e@intel.com>
Date:   Fri, 16 Oct 2020 15:02:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <87v9fa9yq9.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2020 14:50, Jani Nikula wrote:
> On Fri, 16 Oct 2020, Lionel Landwerlin <lionel.g.landwerlin@intel.com> wrote:
>> On 16/10/2020 14:37, Mauro Carvalho Chehab wrote:
>>> Em Fri, 16 Oct 2020 14:01:07 +0300
>>> Joonas Lahtinen <joonas.lahtinen@linux.intel.com> escreveu:
>>>
>>>> + Lionel
>>>>
>>>> Can you please take a look at best resolving the below problem.
>>>>
>>>> Maybe we should eliminate the duplicate declarations? Updating such
>>>> a list manually seems error prone to me.
>>> For Kernel 5.10, IMO the best is to apply this patch as-is, as any
>>> other thing would need to be postponed, and we want 5.10 free of
>>> doc warnings.
>>
>> That's odd... Most of the functions are documented. Is it that we're
>> missing the "()" after the function name maybe?
> The problem is we first include named functions, and then go on to
> include everything again, duplicating the documentation for the named
> functions.
>
> BR,
> Jani.


Thanks, now the patch makes sense.


-Lionel


>
>
>>
>> -Lionel
>>
>>
>>> Yet, when I wrote this one, I almost took a different approach:
>>> to implement something like @*group (or \*group) directives that
>>> exists on doxygen:
>>>
>>> 	https://www.doxygen.nl/manual/grouping.html
>>>
>>> If something like that gets added to kernel-doc syntax, then
>>> one could do something like:
>>>
>>> 	/**
>>> 	 * DOC: some foo description
>>> 	 * @group foo
>>> 	 */
>>>    
>>> 	/**
>>> 	 * foo1 - do some foo things
>>> 	 * @group foo
>>> 	...
>>> 	 */
>>>
>>> 	/**
>>> 	 * foo2 - do some other foo things
>>> 	 * @group foo
>>> 	...
>>> 	 */
>>>
>>> 	/**
>>> 	 * bar - do bar things
>>> 	 * @group bar
>>> 	...
>>> 	 */
>>>
>>>
>>> And then, at kernel-doc markup:
>>>
>>> 	FOO
>>> 	===
>>>
>>> 	.. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
>>> 		:group: foo
>>>
>>>
>>> 	BAR
>>> 	===
>>> 	.. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
>>> 		:group: bar
>>>
>>>
>>> I suspect that something like that would be a lot easier to maintain.
>>>
>>> Once having someone like that implemented, it should be easy to also
>>> have something like this:
>>>
>>> 	OTHERS
>>> 	======
>>> 	.. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
>>> 		:export:
>>> 		:not-grouped:
>>>
>>> in order to pick other functions that aren't grouped.
>>>
>>> I suspect that implementing something like that at kernel-doc.pl
>>> won't be hard.
>>>
>>> Regards,
>>> Mauro
>>>
>>>> Regards, Joonas
>>>>
>>>> Quoting Mauro Carvalho Chehab (2020-10-13 14:53:59)
>>>>> As reported by Sphinx:
>>>>>
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:1147: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_oa_wait_unlocked'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:1169: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_oa_poll_wait'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:1189: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_oa_read'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:2669: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_oa_stream_enable'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:2734: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_oa_stream_disable'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:2820: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_oa_stream_init'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3010: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_perf_read'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3098: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_perf_poll_locked'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3129: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_perf_poll'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3152: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_perf_enable_locked'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3181: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_perf_disable_locked'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3273: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_perf_ioctl'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3296: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_perf_destroy_locked'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3321: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_perf_release'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3379: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_perf_open_ioctl_locked'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3534: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'read_properties_unlocked'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3717: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_perf_open_ioctl'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3760: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_perf_register'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:3789: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_perf_unregister'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:4009: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_perf_add_config_ioctl'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:4162: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_perf_remove_config_ioctl'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:4260: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_perf_init'.
>>>>>           ./Documentation/gpu/i915:646: ./drivers/gpu/drm/i915/i915_perf.c:4423: WARNING: Duplicate C declaration, also defined in 'gpu/i915'.
>>>>>           Declaration is 'i915_perf_fini'.
>>>>>
>>>>> With Sphinx 3, C declarations can't be duplicated anymore,
>>>>> so let's exclude those from the other internals found on
>>>>> i915_perf.c file.
>>>>>
>>>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>>>> ---
>>>>>    Documentation/gpu/i915.rst | 29 +++++++++++++++++++++++++----
>>>>>    1 file changed, 25 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
>>>>> index 33cc6ddf8f64..cff1f154b473 100644
>>>>> --- a/Documentation/gpu/i915.rst
>>>>> +++ b/Documentation/gpu/i915.rst
>>>>> @@ -636,15 +636,36 @@ i915 Perf Observation Architecture Stream
>>>>>    .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
>>>>>       :functions: i915_oa_poll_wait
>>>>>    
>>>>> -All i915 Perf Internals
>>>>> ------------------------
>>>>> +Other i915 Perf Internals
>>>>> +-------------------------
>>>>>    
>>>>> -This section simply includes all currently documented i915 perf internals, in
>>>>> -no particular order, but may include some more minor utilities or platform
>>>>> +This section simply includes all other currently documented i915 perf internals,
>>>>> +in no particular order, but may include some more minor utilities or platform
>>>>>    specific details than found in the more high-level sections.
>>>>>    
>>>>>    .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
>>>>>       :internal:
>>>>> +   :no-identifiers:
>>>>> +       i915_perf_init
>>>>> +       i915_perf_fini
>>>>> +       i915_perf_register
>>>>> +       i915_perf_unregister
>>>>> +       i915_perf_open_ioctl
>>>>> +       i915_perf_release
>>>>> +       i915_perf_add_config_ioctl
>>>>> +       i915_perf_remove_config_ioctl
>>>>> +       read_properties_unlocked
>>>>> +       i915_perf_open_ioctl_locked
>>>>> +       i915_perf_destroy_locked
>>>>> +       i915_perf_read i915_perf_ioctl
>>>>> +       i915_perf_enable_locked
>>>>> +       i915_perf_disable_locked
>>>>> +       i915_perf_poll i915_perf_poll_locked
>>>>> +       i915_oa_stream_init i915_oa_read
>>>>> +       i915_oa_stream_enable
>>>>> +       i915_oa_stream_disable
>>>>> +       i915_oa_wait_unlocked
>>>>> +       i915_oa_poll_wait
>>>>>    
>>>>>    Style
>>>>>    =====
>>>>> -- 
>>>>> 2.26.2
>>>>>     
>>>
>>> Thanks,
>>> Mauro
>>

