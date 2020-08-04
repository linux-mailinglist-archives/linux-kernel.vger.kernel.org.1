Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E9E23B774
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 11:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgHDJRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 05:17:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:39872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgHDJRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:17:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C90EEAD25;
        Tue,  4 Aug 2020 09:17:21 +0000 (UTC)
Message-ID: <1596532623.19923.5.camel@suse.com>
Subject: Re: [PATCH] cdc-acm: rework notification_buffer resizing
From:   Oliver Neukum <oneukum@suse.com>
To:     trix@redhat.com, gregkh@linuxfoundation.org, t-herzog@gmx.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Aug 2020 11:17:03 +0200
In-Reply-To: <20200801152154.20683-1-trix@redhat.com>
References: <20200801152154.20683-1-trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, den 01.08.2020, 08:21 -0700 schrieb trix@redhat.com:
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this error
> 
> cdc-acm.c:409:3: warning: Use of memory after it is freed
>         acm_process_notification(acm, (unsigned char *)dr);
> 
> There are three problems, the first one is that dr is not reset
> 
> The variable dr is set with
> 
> if (acm->nb_index)
> 	dr = (struct usb_cdc_notification *)acm->notification_buffer;
> 
> But if the notification_buffer is too small it is resized with
> 
> 		if (acm->nb_size) {
> 			kfree(acm->notification_buffer);
> 			acm->nb_size = 0;
> 		}
> 		alloc_size = roundup_pow_of_two(expected_size);
> 		/*
> 		 * kmalloc ensures a valid notification_buffer after a
> 		 * use of kfree in case the previous allocation was too
> 		 * small. Final freeing is done on disconnect.
> 		 */
> 		acm->notification_buffer =
> 			kmalloc(alloc_size, GFP_ATOMIC);
> 
> dr should point to the new acm->notification_buffer.
> 
> The second problem is any data in the notification_buffer is lost
> when the pointer is freed.  In the normal case, the current data
> is accumulated in the notification_buffer here.
> 
> 	memcpy(&acm->notification_buffer[acm->nb_index],
> 	       urb->transfer_buffer, copy_size);
> 
> When a resize happens, anything before
> notification_buffer[acm->nb_index] is garbage.
> 
> The third problem is the acm->nb_index is not reset on a
> resizing buffer error.
> 
> So switch resizing to using krealloc and reassign dr and
> reset nb_index.
> 
> Fixes: ea2583529cd1 ("cdc-acm: reassemble fragmented notifications")
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
Acked-by: Oliver Neukum <oneukum@suse.com>

