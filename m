Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6D8230350
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 08:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgG1Gxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 02:53:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50233 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726953AbgG1Gxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595919228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cnw4VeSo1K/0ffNbpoNiFUTzDsP0Bj3EuQOAwAS2EM8=;
        b=I26d42GVm5pcj29ySgoiBhfutOdmEk9RXZNMRJw9SEcgasX9bh2qlsEAs8IjQvRmwVv78F
        WQS4DL+chom+Ti/fs+dVqODfZosM/VjhOMR92+YrnnarlmZOc5rHN07saOqhYHi0qBqFeM
        /36rQJRsjvvWadSsgOOuiWTMuTB7YTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-otXr4YQpMVuWyZLCGjg-0A-1; Tue, 28 Jul 2020 02:53:45 -0400
X-MC-Unique: otXr4YQpMVuWyZLCGjg-0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD293101C8A9;
        Tue, 28 Jul 2020 06:53:43 +0000 (UTC)
Received: from [10.72.13.242] (ovpn-13-242.pek2.redhat.com [10.72.13.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D861860BF4;
        Tue, 28 Jul 2020 06:53:35 +0000 (UTC)
Subject: Re: [PATCH V3 vhost next 00/10] VDPA support for Mellanox ConnectX
 devices
From:   Jason Wang <jasowang@redhat.com>
To:     Eli Cohen <eli@mellanox.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, parav@mellanox.com
References: <20200728060539.4163-1-eli@mellanox.com>
 <1dbac14a-5909-ff0a-8e90-534847f93d50@redhat.com>
 <20200728063211.GA229972@mtl-vdi-166.wap.labs.mlnx>
 <ef857921-4b9a-8e48-d5cd-5ef585e8f15c@redhat.com>
Message-ID: <83eb3fdc-83d5-7f88-bef4-602e60c19662@redhat.com>
Date:   Tue, 28 Jul 2020 14:53:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ef857921-4b9a-8e48-d5cd-5ef585e8f15c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/28 下午2:40, Jason Wang wrote:
>
> On 2020/7/28 下午2:32, Eli Cohen wrote:
>> On Tue, Jul 28, 2020 at 02:18:16PM +0800, Jason Wang wrote:
>>> On 2020/7/28 下午2:05, Eli Cohen wrote:
>>>> Hi Michael,
>>>> please note that this series depends on mlx5 core device driver 
>>>> patches
>>>> in mlx5-next branch in
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git.
>>>>
>>>> git pull 
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git 
>>>> mlx5-next
>>>>
>>>> They also depend Jason Wang's patches submitted a couple of weeks ago.
>>>>
>>>> vdpa_sim: use the batching API
>>>> vhost-vdpa: support batch updating
>>>
>>> Just notice that a new version is posted[1] (you were cced). Talked
>>> with Michael, and it's better for you to merge the new version in
>>> this series.
>>>
>> OK, will send again. Just to make sure, I should put your series and my
>> series on Michal's vhost branch, the same tree I have been using so far?
>
>
> Yes. I think so.
>
> Thanks


Just notice Michael's vhost branch can not compile due to this commit:

commit fee8fe6bd8ccacd27e963b71b4f943be3721779e
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Mon Jul 27 10:51:55 2020 -0400

     vdpa: make sure set_features in invoked for legacy

Let's wait for Michael to clarify the correct branch to use then.

Thanks

