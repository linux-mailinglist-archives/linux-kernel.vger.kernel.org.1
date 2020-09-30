Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EAD27F316
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 22:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgI3URi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 16:17:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31500 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgI3URi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 16:17:38 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601497055;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qR0BZGseTHbNL/WE5CgD2uGFUcNr181CvLX3hUZ/yRQ=;
        b=YatuwFnnFhsQCl3G0NGHH/cS9eWqhfRoLWz+8GYWJrYmSxt53aG0yhqFboQPwUFOJdP6Gc
        v51dxWw/rS7RYRE3gAiFCfYlh0mWA3cDXFdih5+jg1PPaMEBntmwEztnXhUR0j4CeN3XKR
        vEmMiFLKX3nxh46njJnGNJTsvuyDDHY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-tjzo2U2eOdaSrAf9tTjQog-1; Wed, 30 Sep 2020 16:17:33 -0400
X-MC-Unique: tjzo2U2eOdaSrAf9tTjQog-1
Received: by mail-qt1-f200.google.com with SMTP id r22so2050457qtc.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 13:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=qR0BZGseTHbNL/WE5CgD2uGFUcNr181CvLX3hUZ/yRQ=;
        b=TRdAGFqTWV6Lq274l5LZ3ecqXqUpTm46YEpRLAxPeBnUtwkdrbBWhTJIGbS/SWyFJ+
         2yOQuC3rKWU5JzDlLB1SmLUvxzc3c3AtKUFHa6deVtTF5NzuK7vsRBZBr2RczBXPZqGk
         gIZnPXPQJ0Ri/r/X9jFK8RfU8Z/G7MB9rtvThxVN3BDc4GKzf0spcv0/yDM4AUJ6bmdZ
         HbSSCv9mGN5LZ/7SKJgbgkFeBwwRdyMhL0ZsRdLz/xv1MsULysytkg+76m9+eGRtnIYW
         iDe0G+CytSVxfHIpkgLn38MTQN9tkBgNQjyao1axGYhwusogibblMZApLyhDypGEnkIb
         Owtw==
X-Gm-Message-State: AOAM533CQ1gaDxDKH9qSfAsRo0/LH5rMPQILodRUf0BQUx7EBG+GezZT
        I+Mh3MzoH9IWBDfnmY2d7GAL6mZftnywykGznIiUGZB99rILjU5t1j5rdZueKgIgncKJs/vrU+q
        5Nk4wqZRYeZmJuec+6wfXD0++
X-Received: by 2002:a0c:b78c:: with SMTP id l12mr4413979qve.38.1601497053274;
        Wed, 30 Sep 2020 13:17:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ3TC8GL+vzyZ+qTkdpfJhop1qjyPMIEgoMqTXUpuiVjfkcAJXMiqXJAMYGyyIpkiq4xWXXQ==
X-Received: by 2002:a0c:b78c:: with SMTP id l12mr4413964qve.38.1601497053064;
        Wed, 30 Sep 2020 13:17:33 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id 85sm3324528qkn.64.2020.09.30.13.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:17:32 -0700 (PDT)
Message-ID: <e347d9fbd20a778a5610b33e1dfb9966a14dfd8a.camel@redhat.com>
Subject: Re: [PATCH v3 0/2] Add support for F3A
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Vincent Huang <vincent.huang@tw.synaptics.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Andrew Duggan <aduggan@synaptics.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <btissoir@redhat.com>,
        Chris Heiny <chris.heiny@synaptics.com>
Date:   Wed, 30 Sep 2020 16:17:31 -0400
In-Reply-To: <20200930094147.635556-1-vincent.huang@tw.synaptics.com>
References: <20200930094147.635556-1-vincent.huang@tw.synaptics.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the whole series:

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2020-09-30 at 17:41 +0800, Vincent Huang wrote:
> RMI4 F3A supports the touchpad GPIO function, it's designed to support
> more GPIOs and used on newer touchpads. The patches add support of
> touchpad buttons and rename f30_data to avoid confusion.
> 
> Changes in v2:
> - Combined patch 1 and 2 of v1 to fix bisectability.
> 
> Changes in v3:
> - Fix indentations pointed out by Lyude Paul.
> 
> Vincent Huang (2):
>   Input: synaptics-rmi4 - rename f30_data to gpio_data
>   Input: synaptics-rmi4 - add support for F3A
> 
>  drivers/hid/hid-rmi.c           |   2 +-
>  drivers/input/mouse/synaptics.c |   2 +-
>  drivers/input/rmi4/Kconfig      |   8 ++
>  drivers/input/rmi4/Makefile     |   1 +
>  drivers/input/rmi4/rmi_bus.c    |   3 +
>  drivers/input/rmi4/rmi_driver.h |   1 +
>  drivers/input/rmi4/rmi_f30.c    |  14 +-
>  drivers/input/rmi4/rmi_f3a.c    | 240 ++++++++++++++++++++++++++++++++
>  include/linux/rmi.h             |  11 +-
>  9 files changed, 268 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/input/rmi4/rmi_f3a.c
> 
-- 
Sincerely,
      Lyude Paul (she/her)
      Software Engineer at Red Hat

