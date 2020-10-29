Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5BD29EEFA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgJ2O67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:58:59 -0400
Received: from muru.com ([72.249.23.125]:47154 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbgJ2O66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:58:58 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 599A1807E;
        Thu, 29 Oct 2020 14:59:02 +0000 (UTC)
Date:   Thu, 29 Oct 2020 16:58:53 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: Re: [RESEND PATCH 2/4] usb: musb: Fix NULL check on struct
 musb_request field
Message-ID: <20201029145853.GK5639@atomide.com>
References: <20201027164200.18602-1-paul@crapouillou.net>
 <20201027164200.18602-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027164200.18602-3-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul Cercueil <paul@crapouillou.net> [201027 16:42]:
> The 'request' variable is a pointer to the 'request' field of the
> struct musb_request 'req' pointer. It only worked until now because
> the 'request' field is the first one in the musb_request structure, but
> as soon as that changes, the check will be invalid.
> 
> Fix it preventively by doing the NULL-check on the 'req' pointer
> instead.

Acked-by: Tony Lindgren <tony@atomide.com>
