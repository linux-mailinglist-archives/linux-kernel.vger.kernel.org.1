Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408AF1BCC58
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 21:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgD1TYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 15:24:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:44805 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbgD1TYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:24:06 -0400
IronPort-SDR: z0+z5ZQqvdC3c6ZrbKGWaRMwWpkcGr3PyvMLaxJxjM2UcMGMrCGEfr1VrvHxykzJbEHcIlfyWH
 g1e+4GYKzF/Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 12:24:06 -0700
IronPort-SDR: T/B3K3lc8pqz4COy9cHmEL03AuZvF/uAdeQ1z1qa9Kh80pYUM90wduDhSvDC1frXgyY1OgKmsw
 u96f+9NQXaUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="292966103"
Received: from abajayo-mobl1.amr.corp.intel.com (HELO [10.254.110.182]) ([10.254.110.182])
  by fmsmga002.fm.intel.com with ESMTP; 28 Apr 2020 12:24:05 -0700
Subject: Re: [PATCH v1 1/1] drivers: base: Fix NULL pointer exception in
 __platform_driver_probe()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
References: <20200408214003.3356-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20200428190337.GA1719585@kroah.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <2c0c2e54-a385-c4ce-da29-0f84454cce55@linux.intel.com>
Date:   Tue, 28 Apr 2020 12:24:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428190337.GA1719585@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 4/28/20 12:03 PM, Greg KH wrote:
> On Wed, Apr 08, 2020 at 02:40:03PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> If platform bus driver registration is failed then,
> 
> How is your platform driver registration failing?  What caused that, is
> it an in-kernel problem with something?  How can it be triggered?
In my case I triggered it intentionally. For one of our internal
project we want to strictly control the number of drivers/devices
allowed in kernel. To verify the feasibility of adding above support,
I intentionally failed few bus drivers and checked the behavior. In
one of those tests I hence came across the mentioned issue.

In any case, platform bus driver registration failure is a valid case
right ? Any issue we notice when this happens needs to be handled right?
> 
> thanks,
> 
> greg k-h
> 
