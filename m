Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1585D295ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505942AbgJVMm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:42:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:41160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505857AbgJVMm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:42:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5CCA7AD2F;
        Thu, 22 Oct 2020 12:42:56 +0000 (UTC)
Date:   Thu, 22 Oct 2020 14:42:55 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     kaichuan.hsieh@canonical.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware/dmi: Include product_sku info to modalias
Message-ID: <20201022144255.667ca9ce@endymion>
In-Reply-To: <20201022064047.9827-1-kaichuan.hsieh@canonical.com>
References: <20201022064047.9827-1-kaichuan.hsieh@canonical.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Chuan,

On Thu, 22 Oct 2020 14:40:47 +0800, kaichuan.hsieh@canonical.com wrote:
> From: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
> 
> Some Dell platforms rely on modalias to customize configuration,
> the product sku can be more specific for the hardware.
> 
> Add product_sku to modalias for better utilization.

Do you have an actual use case for this already, or is it a theoretical
concern?

-- 
Jean Delvare
SUSE L3 Support
