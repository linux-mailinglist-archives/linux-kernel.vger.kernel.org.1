Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF7A246812
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 16:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgHQOKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 10:10:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49558 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728958AbgHQOKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597673420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k4SVy3Q7kvs9PtLL75xW8B+I2m2NEtNuQTvJNDb9D5o=;
        b=SaDmWaWtIhrYzg2Fxx7gPYdHFvq566gdNC7gqGkIIIDodH3H8MtGHPBptC6R/Cr9tZxIiN
        ayBIfg7gUqCiag5reeRjiucBLdn/QAKiwjfmg6ATPwF4Q/r3HUCWiPHrAzzhZFVzOMTf6z
        pIPbFzQ7gBUVtix2OF9HKOqxJoVfH78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-XR16wYhrOq-qf-SCmeZS5A-1; Mon, 17 Aug 2020 10:10:17 -0400
X-MC-Unique: XR16wYhrOq-qf-SCmeZS5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2835425CF;
        Mon, 17 Aug 2020 14:10:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.59])
        by smtp.corp.redhat.com (Postfix) with SMTP id 69BA5795AE;
        Mon, 17 Aug 2020 14:10:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 17 Aug 2020 16:10:15 +0200 (CEST)
Date:   Mon, 17 Aug 2020 16:10:13 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/2] kernel/sys: only take tasklist_lock for
 get/setpriority(PRIO_PGRP)
Message-ID: <20200817141012.GE29865@redhat.com>
References: <20200817003148.23691-1-dave@stgolabs.net>
 <20200817003148.23691-2-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817003148.23691-2-dave@stgolabs.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16, Davidlohr Bueso wrote:
>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  kernel/sys.c | 16 ++++++++--------

Acked-by: Oleg Nesterov <oleg@redhat.com>

