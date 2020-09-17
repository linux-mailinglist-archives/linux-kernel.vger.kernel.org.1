Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6DF26E25E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 19:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIQR2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 13:28:24 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39160 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgIQR1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:27:40 -0400
Received: from [192.168.0.121] (unknown [209.134.121.133])
        by linux.microsoft.com (Postfix) with ESMTPSA id 85ED720B7178;
        Thu, 17 Sep 2020 10:27:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85ED720B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600363638;
        bh=nNT59xiVCeQuSdxVsqpzlUhi5DP4GXX+M6O78MJ5HUY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lkoFBIEWN/+VNAKO+qdahC0B1JalSQTFsFRk3bY4tTWmN/9VxQKO7EwMKEz6prqEs
         eDXabN+nJtVpb+m05c0qIpvS+S+22q/E1TA0wOZjTg8fhZh15j92OTfWqAqCzcTaFD
         zDqnZGRWqhJF1xzocI27Rh59flOy0NrhQTinPTMw=
Subject: Re: [v4] mm: khugepaged: avoid overriding min_free_kbytes set by user
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1600324779-6782-1-git-send-email-vijayb@linux.microsoft.com>
 <20200917092805.GA29887@dhcp22.suse.cz>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
Message-ID: <21c4788c-2516-2e47-5885-486c352c2b6e@linux.microsoft.com>
Date:   Thu, 17 Sep 2020 10:27:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200917092805.GA29887@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/2020 2:28 AM, Michal Hocko wrote:
> On Wed 16-09-20 23:39:39, Vijay Balakrishna wrote:
>> set_recommended_min_free_kbytes need to honor min_free_kbytes set by the
>> user.  Post start-of-day THP enable or memory hotplug operations can
>> lose user specified min_free_kbytes, in particular when it is higher than
>> calculated recommended value.
> 
> I was about to recommend a more detailed explanation when I have
> realized that this patch is not really needed after all. Unless I am
> missing something.
> 
> init_per_zone_wmark_min ignores the newly calculated min_free_kbytes if
> it is lower than user_min_free_kbytes. So calculated min_free_kbytes >=
> user_min_free_kbytes.
> 
> Except for value clamping when the value is reduced and this likely
> needs fixing. But set_recommended_min_free_kbytes should be fine.
> 

IIUC, after start-of-day if a user performs
- THP disable
- modifies min_free_bytes
- THP enable
above sequence currently wouldn't result in calling init_per_zone_wmark_min.

Thanks,
Vijay
