Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D86301DA6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 17:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbhAXQyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 11:54:41 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:45637 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbhAXQyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 11:54:39 -0500
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id BB5BBA146E;
        Sun, 24 Jan 2021 17:53:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=zVAxrdkhit9I
        bjy8t7Lnq5mScOnP9BWAqNpKmerQ0tc=; b=hKAZ2uYI256rzdDpkFJZo7mJjxhX
        ZmzR209I64z8o3hDC4mBegCGHc0ljSJ7IUgMh+VxOke+A7UndD6xP3nYrF2gcM2q
        a6/Gk+Ey1AxjfYN3/6w+rO06OHpeRVo2wfAGHLsgkaNkcgfKFijsc+EAzZI/TVVG
        nck3iaEr3ym2ploUHcorPkKTESW7D703tqGrlpfDMgyfpS4EO9+f4TENUo3LGzkY
        l+ilYGEYJoGSoo4mJbU+mARKnAIOiHvYTqsH22Q54oYIwh6F5kKJ0nLl9lTprSY3
        4EZcCEvQWrXIOCoyaBOSFhYdQ8A8IJ1Nb5oMWkmbU/KtGGLcQFIBCB0A2w==
Subject: Re: [PATCH 0/7] ALSA: add virtio sound driver
To:     "Girdwood, Liam R" <liam.r.girdwood@intel.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>
References: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
 <3ac230040630c3b6695f8a091e000f5b4f90b3ce.camel@intel.com>
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <52efab17-d6e2-c3f4-c3de-73338b811534@opensynergy.com>
Date:   Sun, 24 Jan 2021 17:53:52 +0100
MIME-Version: 1.0
In-Reply-To: <3ac230040630c3b6695f8a091e000f5b4f90b3ce.camel@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Liam!


On 20.01.2021 11:10, Girdwood, Liam R wrote:
> CAUTION: This email originated from outside of the organization.
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Hi Anton,
> 
> On Wed, 2021-01-20 at 01:36 +0100, Anton Yakovlev wrote:
>> This series implements a driver part of the virtio sound device
>> specification v8 [1].
>>
>> The driver supports PCM playback and capture substreams, jack and
>> channel map controls. A message-based transport is used to write/read
>> PCM frames to/from a device.
>>
>> The series is based (and was actually tested) on Linus's master
>> branch [2], on top of
>>
>> commit 1e2a199f6ccd ("Merge tag 'spi-fix-v5.11-rc4' of ...")
>>
>> As a device part was used OpenSynergy proprietary implementation.
>>
>> Any comments are very welcome.
>>
> 
> This just looks like the guest front end here, do you have a follow up
> series for the host backend ?

As I mentioned in the cover message, as a device part was used our own
proprietary implementation. And there are no plans to upstream that
part.


> Thanks
> 
> Liam
> ---------------------------------------------------------------------
> Intel Corporation (UK) Limited
> Registered No. 1134945 (England)
> Registered Office: Pipers Way, Swindon SN3 1RJ
> VAT No: 860 2173 47
> 
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
> 

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone: +49 30 60 98 54 0
E-Mail: anton.yakovlev@opensynergy.com

www.opensynergy.com

Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616B
Geschäftsführer/Managing Director: Regis Adjamah

