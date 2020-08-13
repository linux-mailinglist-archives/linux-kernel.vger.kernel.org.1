Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA154243C47
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 17:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHMPNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 11:13:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:59222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgHMPN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:13:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7BA67ACF9;
        Thu, 13 Aug 2020 15:13:50 +0000 (UTC)
Subject: Re: [PATCH v2 0/5] Fixes and improvements for Xen pvdrm
To:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
Cc:     "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
References: <20200813062113.11030-1-andr2000@gmail.com>
 <366f5998-4346-6140-b133-23c9abef6589@suse.com>
 <5a71bca8-df90-a239-6a5e-cbc9af30771e@epam.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <2b7568cd-a3e6-a672-e9c4-3e58eecde43b@suse.com>
Date:   Thu, 13 Aug 2020 17:13:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5a71bca8-df90-a239-6a5e-cbc9af30771e@epam.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.08.20 17:10, Oleksandr Andrushchenko wrote:
> 
> On 8/13/20 6:02 PM, Jürgen Groß wrote:
>> On 13.08.20 08:21, Oleksandr Andrushchenko wrote:
>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Series pushed to:
>>
>> xen/tip.git for-linus-5.9
>>
> The top patch has strange title though:
> 
> "Subject: [PATCH v2 5/5] drm/xen-front: Pass dumb buffer data offset to the backend"

Oh, indeed. I had to repair it manually as it seems some mail system
(probably on my end) mangled it a little bit.

Will repair it.


Juergen
