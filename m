Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296E528FAFE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 00:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbgJOWBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 18:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730833AbgJOWBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 18:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602799267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pDWmqUHLp8FIGfU/X7rfOUyiGs+RfGnhGhcKMN8cq6Q=;
        b=IITYNeQFrsh506dWiAWp2hJfdbSfbaFOISZQ5YjcScgUs189+EifMmMferuHK9m1gHRuw9
        QrKHAEH4x8zUA9Dpo2R3Sa6VuVEopgITfAFq3SXkUwx37lZqNbZAHQ8QMBs1NZxuDHDjg5
        Hk+0L0qOqaRrI5shGSPzlB1lPXOYN4Y=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-yL2Wrpx9PYWrszoQ2VvMXw-1; Thu, 15 Oct 2020 18:01:05 -0400
X-MC-Unique: yL2Wrpx9PYWrszoQ2VvMXw-1
Received: by mail-ot1-f69.google.com with SMTP id e6so158874otl.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 15:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=pDWmqUHLp8FIGfU/X7rfOUyiGs+RfGnhGhcKMN8cq6Q=;
        b=CmGaUSfT2jlpIQ3CCboI7CGX9HdK+NjNsUl5F25b2OdH1NydFpeGCKkiVl7W8BL1RL
         fN33dXM0pJsGbVVMhBA8wbwV0DLv9KFx1DDVlaW2Ulg/RFnuN39YiIsuG2fP54E4ryg9
         TM8wKhDGOsEvt9iFTCOo8Wi4JTDtV9bsdX6bd5U137SeVlmAyVNB2CjXwzunx1/xu/OF
         9JmJTPrCtO3Ci1x4UW1bBHIM6m8k39m//TbXCZp4Mi4610C4cf4EpzOHcuqKROrWiYWh
         LSyLafkWrHQosdxPIJvPKRRNPEcX8uWk1RK+ISl3ZWehhrfcKOVmh42L7mSISugFrWlp
         qfCw==
X-Gm-Message-State: AOAM532YUErFEkrJpE6iinzTJqyjdJPxGbR/wgNxjUZz+sfl3qhdbUa5
        fM2IxNGWvxJbEo+BFWcUp1EIRzcchJzUTVBlnZfF2HqxaZmkSqxqO5Li88AENQuqMTGtnrJnDC9
        ymHU5IhZ2diwjTvh4lwTOnsFv
X-Received: by 2002:a9d:6847:: with SMTP id c7mr417950oto.134.1602799264433;
        Thu, 15 Oct 2020 15:01:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxux9nnpe8794oowHdNnMJ76DKX1MNKqZBhVeSffzj8tYw+EXRmhyjkJwc1tly4S0UqOUKlAQ==
X-Received: by 2002:a9d:6847:: with SMTP id c7mr417936oto.134.1602799264234;
        Thu, 15 Oct 2020 15:01:04 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id v123sm178673oif.29.2020.10.15.15.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 15:01:03 -0700 (PDT)
References: <20201015214430.17937-1-jsnitsel@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-kernel@vger.kernel.org, jarkko@kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
In-reply-to: <20201015214430.17937-1-jsnitsel@redhat.com>
Date:   Thu, 15 Oct 2020 15:01:02 -0700
Message-ID: <87imbbtaht.fsf@jsnitsel.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


James should this get tacked on the end of your patchset?

Regards,
Jerry

