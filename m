Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53001287C81
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgJHTce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:32:34 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13437 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJHTce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:32:34 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7f68440000>; Thu, 08 Oct 2020 12:28:04 -0700
Received: from [10.2.85.86] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Oct
 2020 19:28:22 +0000
Subject: Re: [PATCH] Documentation: filesystems: better locations for
 sysfs-pci, sysfs-tagging
To:     Jonathan Corbet <corbet@lwn.net>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
        <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20201007233151.490953-1-jhubbard@nvidia.com>
 <20201008100427.39ca3c1f@lwn.net>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <d91a1088-641c-07e1-4065-bbd8ad79332c@nvidia.com>
Date:   Thu, 8 Oct 2020 12:28:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201008100427.39ca3c1f@lwn.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602185284; bh=SDS6BGkPbeIhE1YR1pvqQexHVFA/bCFdW7c+ZbpQHZc=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=VhSeSrRrNiRttdO08KwCiAM8uK6vaaI2YouT1s+XQOJGBL2Yp5cx2noXhZe8QHRpM
         RwY9KvPRSwwrxcEaNTokxVj7unRI3foMuYEKljGo2v1CnRMYeZmF2EEoMQQ4ifNqGl
         oCGdHzoKe7kGbpPkgTxcjs2KOLmgzvkNoXta8Taig2jCQndhExqc5WM+7vM++rcbJa
         Gj4nKgBebdxSF13ClIHFyV4JLzh83uYBLPcS+8Nm6mupmSvwseb/EvnwruzcVtZV/S
         AvkfsDX9YYfENIUsxS5K7rJkqo3mPYuDKAt7G9CjsyZ7z7QXBvwEtCoswS6qnlz57p
         5CVmUbc31bi3g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/20 9:04 AM, Jonathan Corbet wrote:
> On Wed, 7 Oct 2020 16:31:51 -0700
> John Hubbard <jhubbard@nvidia.com> wrote:
> 
>> sysfs-pci and sysfs-tagging were mis-filed: their locations with
>> Documentation/ implied that they were related to file systems. Actually,
>> each topic is about a very specific *use* of sysfs, and sysfs *happens*
>> to be a (virtual) filesystem, so this is not really the right place.
>>
>> It's jarring to be reading about filesystems in general and then come
>> across these specific details about PCI, and tagging...and then back to
>> general filesystems again.
>>
>> Move sysfs-pci and sysfs-tagging to a location under the sysfs topic.
>>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> I see why you want to do this, but I have to wonder if moving them out of
> Documentation/filesystems entirely might not be a better approach.
> sysfs-pci.rst might better belong in the admin guide or under PCI/, while
> sysfs-tagging.rst could go under networking/.
> 
> Make sense?
> 

Absolutely, I'll post a v2 that does it that way.

thanks,
-- 
John Hubbard
NVIDIA
