Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240D23021E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 06:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbhAYFlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 00:41:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbhAYFl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 00:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611553197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XwObwWA9fXyhzGiJ652Ze6C+PNgOaSeBXRe2BUCfC24=;
        b=QreP/L56BWN+nWaV8eKFB/0dJs8zC9SZRlQ7D5g1dzRNNjbyIkQdxjmdy5hQs1CRi+WxLW
        WPikq7PI3f3RGt5gy4AzKiJW5UXO90yATnsUlAdqOLTOnLt0MXmIHQrwlcs9wPW7WG9Y2I
        nxFVwRufRXPRgyxje2pUOQ2NegJP0xw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-zOc8quYmOFuRDXkNJt48FQ-1; Mon, 25 Jan 2021 00:39:55 -0500
X-MC-Unique: zOc8quYmOFuRDXkNJt48FQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7156918C8C00;
        Mon, 25 Jan 2021 05:39:53 +0000 (UTC)
Received: from suzdal.zaitcev.lan (ovpn-112-54.phx2.redhat.com [10.3.112.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4D2260C5F;
        Mon, 25 Jan 2021 05:39:52 +0000 (UTC)
Date:   Sun, 24 Jan 2021 23:39:52 -0600
From:   Pete Zaitcev <zaitcev@redhat.com>
To:     Jeremy Figgins <kernel@jeremyfiggins.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        zaitcev@redhat.com
Subject: Re: [PATCH] USB: usblp: don't call usb_set_interface if there's a
 single alt
Message-ID: <20210124233924.34d278fc@suzdal.zaitcev.lan>
In-Reply-To: <YAy9kJhM/rG8EQXC@watson>
References: <YAy9kJhM/rG8EQXC@watson>
Organization: Red Hat, Inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jan 2021 18:21:36 -0600
Jeremy Figgins <kernel@jeremyfiggins.com> wrote:

> Signed-off-by: Jeremy Figgins <kernel@jeremyfiggins.com>

> +++ b/drivers/usb/class/usblp.c
> +	if (usblp->intf->num_altsetting > 1) {

Acked-by: Pete Zaitcev <zaitcev@redhat.com>

I am having some misgivings about it, but let's see if it works.
At worst, someone will complain and we'll revert to quirks.

-- Pete

