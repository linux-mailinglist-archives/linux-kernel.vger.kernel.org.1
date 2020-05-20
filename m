Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4641D1DBCCB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 20:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgETS07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 14:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgETS06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:26:58 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99388C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:26:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z72so3928026wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Y/fdBR4NjwtQDCcpCctgOyCn9js/D87HSWqbK2WjCk=;
        b=X4Dyq5Ze9JCoNjG3KsaNqU1dDeKCUMh00Xiz7+8OVNwUiocD0n54uYbDAPqVAc+JPG
         2jr4mRkAj3MRIH3H62IPk0SHcRtbUooIhrXZjOW4OXNF4scXgT5ySHRquY+Lgb61+whu
         mXsmvrHLfNQ3Jh8mB2zUaH1Hmo2Kd1wMnxKJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Y/fdBR4NjwtQDCcpCctgOyCn9js/D87HSWqbK2WjCk=;
        b=G/IAjQ7PmNWWX7IcNplshvBW7CsZ12uXmEtq0uuib6U3V+hoxxfR1EYnbjbHzXLFC6
         OyDPFcAeaBsraii6xqaSJCAGxE4Q2hsHCN+r68JYIYktsCwDiqF3wpE/CDbj3+cpTn44
         LvfhpLDxnNbil3Vl7CIMUnO/jho0mE8jgZ4hsSiGw40FRRGNRB4FK9gDUyME4de7WaVM
         A0RqO9Zl2ZS/cC/wwkFI9DAK7YWW4A5FJLLAPu/xOR8gOJ0v6WN8ia5maXFaH+ku5FCa
         LYq5rRwhar1eO9Qae0ryB+XUDuKF6bm4HUaBYh1lH4UNLGI4n4CadR4ZJXayBh5LpC5l
         AEzA==
X-Gm-Message-State: AOAM531ZQ97xuXADr4el3mcvplOGbrxKBdzpuGKB1GP8hr7mbHbwafQO
        1qKtq7UqsvhzDXEbVl7m21ILqNamxtRtu8Su6mkwHA==
X-Google-Smtp-Source: ABdhPJyKeMi9gaTkOXDaBSgAZ5jBfQr9fDEE+1qJ1e9vX2WhhGVEmL6fshDM82dD1DyIM9MqcUXl+6DgXk1CBF0SP+Y=
X-Received: by 2002:a1c:7305:: with SMTP id d5mr5874355wmb.85.1589999217222;
 Wed, 20 May 2020 11:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
 <20200519203419.12369-10-james.quinlan@broadcom.com> <20200520174216.GA11770@lst.de>
In-Reply-To: <20200520174216.GA11770@lst.de>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 20 May 2020 14:26:43 -0400
Message-ID: <CA+-6iNzy_nELB0ptE0vH5KrGMFq4CctFKDipk3ZzXnjnT9hfuQ@mail.gmail.com>
Subject: Re: [PATCH 09/15] device core: Add ability to handle multiple dma offsets
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I meant to put you on the to-list for all patches.   The last
time I sent out this many patches using a collective cc-list for all
patches I was told to reduce my cc-list.
Jim

On Wed, May 20, 2020 at 1:42 PM Christoph Hellwig <hch@lst.de> wrote:
>
> If you don't Cc me on the whole series I have absolutely no way to
> review it.  Don't ever do these stupid partial Ccs as they cause nothing
> but pain.
