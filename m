Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B0529BACC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1807665AbgJ0QMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:12:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:50390 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1807623AbgJ0QMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:12:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D25F5ACE6;
        Tue, 27 Oct 2020 16:12:18 +0000 (UTC)
Date:   Tue, 27 Oct 2020 17:12:17 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware/dmi: Include product_sku info to modalias
Message-ID: <20201027171217.4c05a8a2@endymion>
In-Reply-To: <ba8ca9b3-da06-4543-6804-ac0d47f26b06@canonical.com>
References: <20201022064047.9827-1-kaichuan.hsieh@canonical.com>
        <20201022144255.667ca9ce@endymion>
        <ba8ca9b3-da06-4543-6804-ac0d47f26b06@canonical.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Chuan,

On Thu, 22 Oct 2020 21:11:32 +0800, Kai-Chuan Hsieh wrote:
> There are multiple product skus share the same product name, like 
> clamshell and 2-in-1 for Latitude series.
> Both of them have 3-axis accelerator, but rotation is only disable for 
> clamshell model.
> Originally, it should be descriminated by chassis_type, but found that 
> chassis_type is not trustful.
> https://github.com/systemd/systemd/pull/17084#issuecomment-706931881
> Therefore, I would like to propose a change to include the product_sku 
> for applying customized configuration easier.

OK. On the principle I'm fine with the change. As far as the
implementation details go, I'd rather stick to 3 letters maximum as we
did for other fields, to keep the overall string as short as possible.
This also has the nice effect that you wouldn't need to realign
everything, which would make the patch more readable too.

So please go with either "sku" (my preference) or "psk".

Thanks,
-- 
Jean Delvare
SUSE L3 Support
