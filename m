Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D372CCA95
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 00:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgLBXki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 18:40:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbgLBXki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 18:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606952352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iOY+ua6LPPG5oekDwz+/gTzCdxqCxzuOLrGK0RqQFSU=;
        b=jJDRum2v5fRDSyQhLSX4KYlSXTUj9bdKCAi8/HPfPLb5LhMBhl8GalaIqjJB2m4kTKJPql
        Rp1oPL9k3q72TrBEXpEeSaMP3xHimEYmiuMvqe/V7HOTR+sIUm2kD8izs/A4jP7T3b3FXA
        V1srqPDH/7/tSGNRVYOVAywxhybZyfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-3NaYKUlPNz-6W4_an8MlkA-1; Wed, 02 Dec 2020 18:39:08 -0500
X-MC-Unique: 3NaYKUlPNz-6W4_an8MlkA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6BB7809DC3;
        Wed,  2 Dec 2020 23:39:07 +0000 (UTC)
Received: from ovpn-66-132.rdu2.redhat.com (unknown [10.10.67.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3EDDA60854;
        Wed,  2 Dec 2020 23:39:07 +0000 (UTC)
Message-ID: <9d854812b07d8a7516274ea47739158c34cfce08.camel@redhat.com>
Subject: Re: [PATCH] mm/swapfile: Do not sleep with a spin lock held
From:   Qian Cai <qcai@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Dec 2020 18:39:06 -0500
In-Reply-To: <20201202151556.01077710acf79f6fd2ba8287@linux-foundation.org>
References: <20201202151549.10350-1-qcai@redhat.com>
         <20201202151556.01077710acf79f6fd2ba8287@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-12-02 at 15:15 -0800, Andrew Morton wrote:
> On Wed,  2 Dec 2020 10:15:49 -0500 Qian Cai <qcai@redhat.com> wrote:
> 
> > We can't call kvfree() with a spin lock held, so defer it.
> > 
> 
> Fixes: 873d7bcfd066 ("mm/swapfile.c: use kvzalloc for swap_info_struct
> allocatio
> n")
> 
> Do you think it's worth a cc:stable?  IOW, is this known to ever
> produce a warning?

Yes, it did trigger a might_sleep() warning.

