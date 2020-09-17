Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2919C26D3B2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 08:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgIQGcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 02:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgIQGcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 02:32:13 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2BD721973
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600324333;
        bh=Sd11XAvUkABH+JeORY9JB4/9xsVSvX16hOT60suqWCM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zd2pH3wryXPSI9bnQZ90pWR8YNhKF7vDJwU2AcUR93YPdmDDZRLSliUgtwzA3sWUG
         q2L14pe4y9L0UQ5ldX4gqjTcZoSSvI8PgMaaFp9Cw54e55biS9pPonwwcbc7b7OE6V
         ioJHsD94YdY01hcKjX1jDQc3PhND5E8brgZxkmiM=
Received: by mail-lj1-f182.google.com with SMTP id a22so965846ljp.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:32:12 -0700 (PDT)
X-Gm-Message-State: AOAM532UiTE2WPy7phuuypVPvuPnanmIQNE2gbaqlFXtQsIaMR1gXNTD
        ISFbafupSWtK4SY+8ZHJGv0/Zr8MPTO2i+YZSJ4=
X-Google-Smtp-Source: ABdhPJywNxE4UmZJGPWHzkX9fivgOE0rU+GYKa7qqUnDzw2HFOG8eGGi2lLWmNRV0Naaryzc/8JN872kWiRy2E+I05w=
X-Received: by 2002:a2e:7a09:: with SMTP id v9mr9486680ljc.82.1600324331009;
 Wed, 16 Sep 2020 23:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200916160552.1062243-1-ribalda@kernel.org> <20200916162824.GC6374@sirena.org.uk>
In-Reply-To: <20200916162824.GC6374@sirena.org.uk>
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
Date:   Thu, 17 Sep 2020 08:31:54 +0200
X-Gmail-Original-Message-ID: <CAPybu_20oay941cqHqa_D13cN0XCrk=Pa113ZuwbbAuVC3yX3A@mail.gmail.com>
Message-ID: <CAPybu_20oay941cqHqa_D13cN0XCrk=Pa113ZuwbbAuVC3yX3A@mail.gmail.com>
Subject: Re: [PATCH] regmap: Add support for 12/20 register formatting
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark




On Wed, Sep 16, 2020 at 6:29 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Sep 16, 2020 at 06:05:52PM +0200, Ricardo Ribalda wrote:
> > From: Ricardo Ribalda <ricardo@ribalda.com>
> >
> > Devices such as the AD5628 require 32 bits of data divided in 12 bits
> > for dummy, command and address, and 20 for data and dummy.
>
> What exactly is the format you're trying to describe here?  It sounds
> like there's two blocks of padding in here (I'm assuing that's what
> dummy means) but what's the exact arrangement here and what are the
> commands?  It sounds like this might not work ideally with things like
> the cache code (if it makes things seems sparser than they are) and
> might not be obvious to someone looking at the datsheet.

The format is

XXXXCCCCAAAADDDDDDDDDDDDDDDDXXXX

Where X is dont care, C is command, A is address and D is data bits. I
am using the following config successfully:

static const struct regmap_config config_dac = {
.reg_bits = 12,
.val_bits = 20,
.max_register = 0xff,
};

Shall I add this to the commit message? I want to send a V2 anyway,
because I screwed up the identity (ribalda.com instead of kernel.org)

Thanks
