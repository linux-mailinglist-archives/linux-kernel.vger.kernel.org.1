Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650EB1C8F4C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 16:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgEGOac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 10:30:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49475 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728767AbgEGOaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588861806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rj5kOWwabzY7Fn7PlvPr8yLZoyzAXjgTM69IXu1oI44=;
        b=STC8zExZjayDbyGAYOoJbJG7K3uWyKggGkMsr6DYRijFu8kw8En09KWwX+7RjefgErK8NH
        ZVKq1hyjvlovGiASfuwIq0kIrM/oo43C6nn0i8FvV1H7M3qtlAt3U6wPhhRCF6mBZSmE5N
        hQR8d+JRFi1V3hGvCQ1L4Ng4phTiSgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-9L22ZqmFO1-qQl2tFhXbWQ-1; Thu, 07 May 2020 10:30:03 -0400
X-MC-Unique: 9L22ZqmFO1-qQl2tFhXbWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57915107ACF3;
        Thu,  7 May 2020 14:30:02 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 597E7707A9;
        Thu,  7 May 2020 14:29:59 +0000 (UTC)
Date:   Thu, 7 May 2020 10:29:58 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Samuel Zou <zou_wei@huawei.com>
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dm mpath: Remove unused variable ret
Message-ID: <20200507142958.GA12032@redhat.com>
References: <1588854412-19301-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588854412-19301-1-git-send-email-zou_wei@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07 2020 at  8:26am -0400,
Samuel Zou <zou_wei@huawei.com> wrote:

> This patch fixes below warning reported by coccicheck:
> 
> drivers/md/dm-historical-service-time.c:240:14-16: Unneeded variable: "sz". Return "0" on line 261
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Samuel Zou <zou_wei@huawei.com>

Nack.

DMEMIT() uses the local sz variable.

