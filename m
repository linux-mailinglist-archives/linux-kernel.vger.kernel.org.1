Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA32211731
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 02:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgGBA2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 20:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgGBA2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 20:28:47 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E489DC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 17:28:46 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x62so19966536qtd.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 17:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=tEp83WGu1CaOEFl+K8s7bEAoLTDYi1bK3tdrG0n3i58=;
        b=ncJAHFNP2mUS16ek6ocVcbkOkBLX4LEhtpXxgXDSlDlZTiniqP/IMOOQRbduNM4WPT
         BT75e5/hQ995AowVidXtuGVqGcuIZSIYPQ8iTjzBTvtvX8Rjfaszmz7e3yOvOrQaomqB
         V387WtuRgzqh3sFjrIBjieDJgICrF+EkODT/KDcBKgpzqIrAHnB9ifyrWoV8LbxeYfbO
         vkGWOJo7Sne5YK+ILfnG8NUOML26lBXtcvYveS3HzNeM0VCQTUiWG7tNCf41CaA+sdNQ
         5mHKVEo6tChAOIUGwf5koKEnlA4hRZND+DpTSYtPgOp74fSdYqUkWk8iUS/PB6WlE1ir
         Us+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=tEp83WGu1CaOEFl+K8s7bEAoLTDYi1bK3tdrG0n3i58=;
        b=c6x4MSsLtQXVh1rJmu8oo9dZ38xzvT/wyx2wJKWtmsmb/+djyThmyL6oKiVKQlrfd8
         WK5Ie8RGUKEy2colfHWVk/LReopuV3EjzYgGZbS/A/IJvlUthb9+Tnsm/CSp6PLVZI4S
         pAwfu8GiefXTlRers6nEZBAeYISmHQjEKVCCB8upS2k/XrdJCPXkbrCyLuBAzCJbsFXz
         AlBe6ssQZ7UUWNqMxicW9wr11FwUoAi4gB3u7mUDeLNrbILgdbmNesMwMFjRtc1fUANd
         WBfyCk+GgugnsXvEIthTySFRqi56qMCzjL9+IyZVcjtqahlQ+BweC7ABKhFoZ3jX/WK/
         LO6g==
X-Gm-Message-State: AOAM53355WRajsLYYIFCHDmdEUncTob5Q6W5MS/7AZptIqXnKQVD0/Ir
        VnCWu86dq26i0d0x9lw/Ack=
X-Google-Smtp-Source: ABdhPJxXQ0sVDarg6OPQsOUa0xF+mFPYf/tqtTaKldHc7fWWcm/Ei8SRTT0IcnOvsC+FMTPnAsxkRw==
X-Received: by 2002:ac8:1ac4:: with SMTP id h4mr29806929qtk.249.1593649726204;
        Wed, 01 Jul 2020 17:28:46 -0700 (PDT)
Received: from LeoBras (200-236-245-17.dynamic.desktop.com.br. [200.236.245.17])
        by smtp.gmail.com with ESMTPSA id z1sm244737qkl.74.2020.07.01.17.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 17:28:45 -0700 (PDT)
Message-ID: <8f4c405363e4cd2a5a113f2a9a3f11a575d2947a.camel@gmail.com>
Subject: Re: [PATCH v2 2/6] powerpc/pseries/iommu: Update call to
 ibm,query-pe-dma-windows
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Jul 2020 21:28:40 -0300
In-Reply-To: <47ad4907-5f63-56e1-2985-a7a7f4d0ba35@ozlabs.ru>
References: <20200624062411.367796-1-leobras.c@gmail.com>
         <20200624062411.367796-3-leobras.c@gmail.com>
         <5411e8a1-02a3-1287-40bf-ccc9db7a4f88@ozlabs.ru>
         <fbcbc7eb298930195b7146221dc1eded6bf556e4.camel@gmail.com>
         <47ad4907-5f63-56e1-2985-a7a7f4d0ba35@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-07-02 at 10:18 +1000, Alexey Kardashevskiy wrote:
> 
> On 02/07/2020 00:04, Leonardo Bras wrote:
> > On Wed, 2020-07-01 at 18:17 +1000, Alexey Kardashevskiy wrote:
> > > > +#define DDW_EXT_SIZE		0
> > > > +#define DDW_EXT_RESET_DMA_WIN	1
> > > > +#define DDW_EXT_QUERY_OUT_SIZE	2
> > > 
> > > #define DDW_EXT_LAST (DDW_EXT_QUERY_OUT_SIZE + 1)
> > > ...
> > > 
> > > 
> > > > +
> > > >  static struct iommu_table_group *iommu_pseries_alloc_group(int node)
> > > >  {
> > > >  	struct iommu_table_group *table_group;
> > > > @@ -339,7 +343,7 @@ struct direct_window {
> > > >  /* Dynamic DMA Window support */
> > > >  struct ddw_query_response {
> > > >  	u32 windows_available;
> > > > -	u32 largest_available_block;
> > > > +	u64 largest_available_block;
> > > >  	u32 page_size;
> > > >  	u32 migration_capable;
> > > >  };
> > > > @@ -875,13 +879,29 @@ static int find_existing_ddw_windows(void)
> > > >  machine_arch_initcall(pseries, find_existing_ddw_windows);
> > > >  
> > > >  static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
> > > > -			struct ddw_query_response *query)
> > > > +		     struct ddw_query_response *query,
> > > > +		     struct device_node *parent)
> > > >  {
> > > >  	struct device_node *dn;
> > > >  	struct pci_dn *pdn;
> > > > -	u32 cfg_addr;
> > > > +	u32 cfg_addr, query_out[5], ddw_ext[DDW_EXT_QUERY_OUT_SIZE + 1];
> > > 
> > > ... and use DDW_EXT_LAST here.
> > 
> > Because of the growing nature of ddw-extensions, I intentionally let
> > this be (DDW_EXT_QUERY_OUT_SIZE + 1). If we create a DDW_EXT_LAST, it
> > will be incremented in the future if more extensions come to exist.
> > 
> > I mean, I previously saw no reason for allocating space for extensions
> > after the desired one, as they won't be used here.
> 
> Ah, my bad, you're right.
> 
> 
> > > 
> > > >  	u64 buid;
> > > > -	int ret;
> > > > +	int ret, out_sz;
> > > > +
> > > > +	/*
> > > > +	 * From LoPAR level 2.8, "ibm,ddw-extensions" index 3 can rule how many
> > > > +	 * output parameters ibm,query-pe-dma-windows will have, ranging from
> > > > +	 * 5 to 6.
> > > > +	 */
> > > > +
> > > > +	ret = of_property_read_u32_array(parent, "ibm,ddw-extensions",
> > > > +					 &ddw_ext[0],
> > > > +					 DDW_EXT_QUERY_OUT_SIZE + 1);
> > 
> > In this case, I made sure not to cross (DDW_EXT_QUERY_OUT_SIZE + 1)
> > while reading the extensions from the property.
> > 
> > What do you think about it? 
> 
> I think you want something like:
> 
> static inline int ddw_read_ext(const struct device_node *np, int extnum,
> u32 *ret)
> {
> retun of_property_read_u32_index(np, "ibm,ddw-extensions", extnum + 1, ret);
> }
> 
> These "+1"'s all over the place are confusing.

That's a great idea!

I was not aware it was possible to read a single value[index] directly
from the property, but it makes total sense to use it.

Thank you!

