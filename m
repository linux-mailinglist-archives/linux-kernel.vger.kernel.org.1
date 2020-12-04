Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B802CE5F9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgLDCzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 21:55:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49108 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbgLDCzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 21:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607050419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aYyPItDtofx2TMiKK9YfkgNw2PWQqyYSINgpGlu4IEI=;
        b=gUSA/SjxoCxI9x3FN6DifIdoNA154nK6SLocmpA8Tvkbn0+AF/W0BVI+u6IG4CIlrgnVt6
        Gz3adV/PoGwHcHEW2wLBfiYmKwEzmC1KRCYpepqswdv1wR4lHtUt6amaYTe6I8XSboGOSz
        V4BcWWSfvL7krLK9hcROp7lpMrbI/hs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-9UnpziFBPRC6VoqCTN-m8A-1; Thu, 03 Dec 2020 21:53:36 -0500
X-MC-Unique: 9UnpziFBPRC6VoqCTN-m8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC12F8049C1;
        Fri,  4 Dec 2020 02:53:34 +0000 (UTC)
Received: from [10.72.12.116] (ovpn-12-116.pek2.redhat.com [10.72.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3EBC41A4D0;
        Fri,  4 Dec 2020 02:53:29 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
To:     Eli Cohen <elic@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Cindy Lu <lulu@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
 <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
 <20201202055714.GA224423@mtl-vdi-166.wap.labs.mlnx>
 <20201202041518-mutt-send-email-mst@kernel.org>
 <3e32ef6d-83c9-5866-30e5-f6eeacd5044d@redhat.com>
 <20201202165932-mutt-send-email-mst@kernel.org>
 <20201203064928.GA27404@mtl-vdi-166.wap.labs.mlnx>
 <20201203054330-mutt-send-email-mst@kernel.org>
 <20201203120929.GA38007@mtl-vdi-166.wap.labs.mlnx>
 <20201203071414-mutt-send-email-mst@kernel.org>
 <20201203122421.GB38007@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <b74596fe-fff3-2144-b41a-b9898b6933da@redhat.com>
Date:   Fri, 4 Dec 2020 10:53:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203122421.GB38007@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/3 下午8:24, Eli Cohen wrote:
>>> It is mentioned in Parav's patchset that this will be coming in a
>>> subsequent patch to his vdpa tool.
>> So I think kernel has two options:
>> - require a mac when device is created, we supply it to guest
> Yes, the driver should always set VIRTIO_NET_F_MAC and provide a MAC -
> either random or whatever configured using the vdpa too.


A questions here, I think current mlx5 vdpa works for VF only. So I 
think the VF should have a given MAC? If yes, can we use that MAC?

Thanks


>

