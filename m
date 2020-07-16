Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA92221DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 10:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgGPINg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 04:13:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55246 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725831AbgGPINf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594887214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KNspZOYeXPNEGhnpGmkV6yRlFjwe98L5l1zZfV35HAA=;
        b=PZ/WFg/xv08aYtZyk90V+zJK7onLiMPFqGTLmAFYtbCL+fs5fQsepWDoiHLgNJxTDarjpE
        9nR1f6tk9m3T22tdlFKKlfY5UTKc6kS3Whzt9a51Lays9XTNjNGiOBegPH8MDh260xwXS5
        DDLtrm+UuWo8Ag4QkeZXZJ/BTiY/5uk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-7O40IOJAPfKPQG8lgD2MZg-1; Thu, 16 Jul 2020 04:13:30 -0400
X-MC-Unique: 7O40IOJAPfKPQG8lgD2MZg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 465061080;
        Thu, 16 Jul 2020 08:13:29 +0000 (UTC)
Received: from [10.72.12.131] (ovpn-12-131.pek2.redhat.com [10.72.12.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B37727980F;
        Thu, 16 Jul 2020 08:13:23 +0000 (UTC)
Subject: Re: [PATCH vhost next 09/10] vdpa/mlx5: Add shared memory
 registration code
To:     Eli Cohen <eli@mellanox.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com,
        Parav Pandit <parav@mellanox.com>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-10-eli@mellanox.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <61765932-5411-9f37-3a4a-ca5ac5daa28e@redhat.com>
Date:   Thu, 16 Jul 2020 16:13:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716072327.5359-10-eli@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/16 下午3:23, Eli Cohen wrote:
> Add code to support registering guest's memory region for the device.


It would be better to use "userspace" memory here since vhost-vDPA could 
be used by e.g dpdk application on the host in the future.

Thanks


