Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1835E2EFD24
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 03:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbhAIC1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 21:27:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57228 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725817AbhAIC1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 21:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610159177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3deUTSWo7icL2/kX+c+a8SQqHFNh2K28a4hRCkAQWWY=;
        b=MXHXsDLPE4rz/iUqDzwpKcbgyFlqnhH0mpTWWPR0aFq7/l1bheELs8g7qSbZUpjdCsqGNj
        Yb88IkVhyjbIbX43x8ViqAG1d3oeyp/y+RgJrSwcul14IvTlWF1ht+MzRHK6BaluIYN8ND
        KmpEcZgI359tN/swTtY385Q/yovVHT0=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-RfUJRV4iMi2c-ti6Wfn8og-1; Fri, 08 Jan 2021 21:26:16 -0500
X-MC-Unique: RfUJRV4iMi2c-ti6Wfn8og-1
Received: by mail-io1-f69.google.com with SMTP id l20so9278692ioc.20
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 18:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3deUTSWo7icL2/kX+c+a8SQqHFNh2K28a4hRCkAQWWY=;
        b=sYjB3ZgiKXi8/NrWNn4QL6SnTKmQVrY6UzBkXtCOe5g6QAZl7Ei+RiOQIzI3JSH4oq
         LefNfOxaZuQn+Gjd40EHa+gRTSA4HtFMkffcYVxcK/Hx1hntJfPQa4St3Dbjfegg/wKN
         5wD3imU+TG2yk5ngPIyrqd6iGbkYSvc3bXQZIiigNL0jg2Gtde+JBy9NhyN4sM5Hjb2t
         OMJVnHEVsN09vwiYBdOstNKzVWBHdZfYUFj/YyOAkDYGOXOBOK9urmMJtaZR4N8en2Ba
         KwXn2fkdYzS3TPRIUFOMOytebKZ2JvuhoIxp+SdEfeZSRZ/Z7GuIY9di2byrxL/yTNF9
         lViw==
X-Gm-Message-State: AOAM533iYlq55Lu7TpxJaJCXi7VoBEoLeoygV0yz4bORC8eRx7AKbKxw
        fpWVdbbxXDtWmhtQvetwAXvYsaf8/ClvokaAshb9AIpCgVHWXJC8iXIlFIAdnc//TWJCL/poyIL
        4QCLSH3/ly8cazqAqUaEA3DEo
X-Received: by 2002:a92:6e12:: with SMTP id j18mr6527506ilc.47.1610159175660;
        Fri, 08 Jan 2021 18:26:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzp6AdgQP1S6tAvq+SLTyOQGHsKz+zbQT3eexm4d0LcPmSvkxbYAXledHnV+hNlWHIra9IjOQ==
X-Received: by 2002:a92:6e12:: with SMTP id j18mr6527493ilc.47.1610159175334;
        Fri, 08 Jan 2021 18:26:15 -0800 (PST)
Received: from xps13 ([2605:a601:a63a:4d01:b7b1:2714:939a:40b8])
        by smtp.gmail.com with ESMTPSA id s10sm3003553iob.4.2021.01.08.18.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 18:26:14 -0800 (PST)
Date:   Fri, 8 Jan 2021 21:26:12 -0500
From:   Jeremy Cline <jcline@redhat.com>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kent Russell <kent.russell@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdkfd: Fix out-of-bounds read in
 kdf_create_vcrat_image_cpu()
Message-ID: <20210109022612.GB248768@xps13>
References: <20210108163104.411442-1-jcline@redhat.com>
 <a341f82d-5933-3df3-f665-cbb4fb5fc5ff@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a341f82d-5933-3df3-f665-cbb4fb5fc5ff@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 06:46:17PM -0500, Felix Kuehling wrote:
> Am 2021-01-08 um 11:31 a.m. schrieb Jeremy Cline:
> > KASAN reported a slab-out-of-bounds read of size 1 in
> > kdf_create_vcrat_image_cpu().
> >
> > This occurs when, for example, when on an x86_64 with a single NUMA node
> > because kfd_fill_iolink_info_for_cpu() is a no-op, but afterwards the
> > sub_type_hdr->length, which is out-of-bounds, is read and multiplied by
> > entries. Fortunately, entries is 0 in this case so the overall
> > crat_table->length is still correct.
> 
> That's a pretty big change to fix that. Wouldn't it be enough to add a
> simple check after calling kfd_fill_iolink_info_for_cpu:
> 
>     if (entries) {
>     	crat_table->length += (sub_type_hdr->length * entries);
>     	crat_table->total_entries += entries;
>     }
> 
> Or change the output parameters of the kfd_fill_..._for_cpu functions
> from num_entries to size_filled, so the caller doesn't need to read
> sub_type_hdr->length any more.
> 

For sure. I felt like this was a bit tidier afterwards, but that's an
opinion and not one I hold strongly. I'll look at preparing a smaller fix
next week.

Thanks,
Jeremy

> >
> > This refactors the helper functions to accept the crat_table directly
> > and calculate the table entry pointer based on the current table length.
> > This allows us to avoid an out-of-bounds read and hopefully makes the
> > pointer arithmetic clearer. It should have no functional change beyond
> > removing the out-of-bounds read.
> >
> > Fixes: b7b6c38529c9 ("drm/amdkfd: Calculate CPU VCRAT size dynamically (v2)")
> > Signed-off-by: Jeremy Cline <jcline@redhat.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 86 +++++++++++++--------------
> >  1 file changed, 40 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > index 8cac497c2c45..e50db2c0f4ee 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > @@ -829,21 +829,24 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
> >  /* kfd_fill_cu_for_cpu - Fill in Compute info for the given CPU NUMA node
> >   *
> >   *	@numa_node_id: CPU NUMA node id
> > - *	@avail_size: Available size in the memory
> > - *	@sub_type_hdr: Memory into which compute info will be filled in
> > + *	@avail_size: Available space in bytes at the end of the @crat_table.
> > + *	@crat_table: The CRAT table to append the Compute info to;
> > + *		on success the table length and total_entries count is updated.
> >   *
> >   *	Return 0 if successful else return -ve value
> >   */
> >  static int kfd_fill_cu_for_cpu(int numa_node_id, int *avail_size,
> > -				int proximity_domain,
> > -				struct crat_subtype_computeunit *sub_type_hdr)
> > +				struct crat_header *crat_table)
> >  {
> >  	const struct cpumask *cpumask;
> > +	struct crat_subtype_computeunit *sub_type_hdr;
> >  
> >  	*avail_size -= sizeof(struct crat_subtype_computeunit);
> >  	if (*avail_size < 0)
> >  		return -ENOMEM;
> >  
> > +	sub_type_hdr = (typeof(sub_type_hdr))((char *)crat_table +
> > +		crat_table->length);
> >  	memset(sub_type_hdr, 0, sizeof(struct crat_subtype_computeunit));
> >  
> >  	/* Fill in subtype header data */
> > @@ -855,36 +858,42 @@ static int kfd_fill_cu_for_cpu(int numa_node_id, int *avail_size,
> >  
> >  	/* Fill in CU data */
> >  	sub_type_hdr->flags |= CRAT_CU_FLAGS_CPU_PRESENT;
> > -	sub_type_hdr->proximity_domain = proximity_domain;
> > +	sub_type_hdr->proximity_domain = crat_table->num_domains;
> >  	sub_type_hdr->processor_id_low = kfd_numa_node_to_apic_id(numa_node_id);
> >  	if (sub_type_hdr->processor_id_low == -1)
> >  		return -EINVAL;
> >  
> >  	sub_type_hdr->num_cpu_cores = cpumask_weight(cpumask);
> >  
> > +	crat_table->length += sub_type_hdr->length;
> > +	crat_table->total_entries++;
> > +
> >  	return 0;
> >  }
> >  
> >  /* kfd_fill_mem_info_for_cpu - Fill in Memory info for the given CPU NUMA node
> >   *
> >   *	@numa_node_id: CPU NUMA node id
> > - *	@avail_size: Available size in the memory
> > - *	@sub_type_hdr: Memory into which compute info will be filled in
> > + *	@avail_size: Available space in bytes at the end of the @crat_table.
> > + *	@crat_table: The CRAT table to append the Memory info to;
> > + *		on success the table length and total_entries count is updated.
> >   *
> >   *	Return 0 if successful else return -ve value
> >   */
> >  static int kfd_fill_mem_info_for_cpu(int numa_node_id, int *avail_size,
> > -			int proximity_domain,
> > -			struct crat_subtype_memory *sub_type_hdr)
> > +			struct crat_header *crat_table)
> >  {
> >  	uint64_t mem_in_bytes = 0;
> >  	pg_data_t *pgdat;
> >  	int zone_type;
> > +	struct crat_subtype_memory *sub_type_hdr;
> >  
> >  	*avail_size -= sizeof(struct crat_subtype_memory);
> >  	if (*avail_size < 0)
> >  		return -ENOMEM;
> >  
> > +	sub_type_hdr = (typeof(sub_type_hdr))((char *)crat_table +
> > +		crat_table->length);
> >  	memset(sub_type_hdr, 0, sizeof(struct crat_subtype_memory));
> >  
> >  	/* Fill in subtype header data */
> > @@ -905,27 +914,37 @@ static int kfd_fill_mem_info_for_cpu(int numa_node_id, int *avail_size,
> >  
> >  	sub_type_hdr->length_low = lower_32_bits(mem_in_bytes);
> >  	sub_type_hdr->length_high = upper_32_bits(mem_in_bytes);
> > -	sub_type_hdr->proximity_domain = proximity_domain;
> > +	sub_type_hdr->proximity_domain = crat_table->num_domains;
> > +
> > +	crat_table->length += sub_type_hdr->length;
> > +	crat_table->total_entries++;
> >  
> >  	return 0;
> >  }
> >  
> >  #ifdef CONFIG_X86_64
> > +/* kfd_fill_iolink_info_for_cpu() - Add IO link info to a Virtual CRAT
> > + *
> > + * @numa_node_id: The NUMA node ID for the CPU; as from for_each_online_node()
> > + * @avail_size: Available space in bytes at the end of the @crat_table.
> > + * @crat_table: The CRAT table to append the IO link info to; on success the
> > + *              table length and total_entries count is updated.
> > + *
> > + * Return: 0 if successful else return -ve value
> > + */
> >  static int kfd_fill_iolink_info_for_cpu(int numa_node_id, int *avail_size,
> > -				uint32_t *num_entries,
> > -				struct crat_subtype_iolink *sub_type_hdr)
> > +				struct crat_header *crat_table)
> >  {
> >  	int nid;
> >  	struct cpuinfo_x86 *c = &cpu_data(0);
> >  	uint8_t link_type;
> > +	struct crat_subtype_iolink *sub_type_hdr;
> >  
> >  	if (c->x86_vendor == X86_VENDOR_AMD)
> >  		link_type = CRAT_IOLINK_TYPE_HYPERTRANSPORT;
> >  	else
> >  		link_type = CRAT_IOLINK_TYPE_QPI_1_1;
> >  
> > -	*num_entries = 0;
> > -
> >  	/* Create IO links from this node to other CPU nodes */
> >  	for_each_online_node(nid) {
> >  		if (nid == numa_node_id) /* node itself */
> > @@ -935,6 +954,8 @@ static int kfd_fill_iolink_info_for_cpu(int numa_node_id, int *avail_size,
> >  		if (*avail_size < 0)
> >  			return -ENOMEM;
> >  
> > +		sub_type_hdr = (typeof(sub_type_hdr))((char *)crat_table +
> > +			crat_table->length);
> >  		memset(sub_type_hdr, 0, sizeof(struct crat_subtype_iolink));
> >  
> >  		/* Fill in subtype header data */
> > @@ -947,8 +968,8 @@ static int kfd_fill_iolink_info_for_cpu(int numa_node_id, int *avail_size,
> >  		sub_type_hdr->proximity_domain_to = nid;
> >  		sub_type_hdr->io_interface_type = link_type;
> >  
> > -		(*num_entries)++;
> > -		sub_type_hdr++;
> > +		crat_table->length += sub_type_hdr->length;
> > +		crat_table->total_entries++;
> >  	}
> >  
> >  	return 0;
> > @@ -966,12 +987,8 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
> >  	struct crat_header *crat_table = (struct crat_header *)pcrat_image;
> >  	struct acpi_table_header *acpi_table;
> >  	acpi_status status;
> > -	struct crat_subtype_generic *sub_type_hdr;
> >  	int avail_size = *size;
> >  	int numa_node_id;
> > -#ifdef CONFIG_X86_64
> > -	uint32_t entries = 0;
> > -#endif
> >  	int ret = 0;
> >  
> >  	if (!pcrat_image)
> > @@ -1003,48 +1020,25 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
> >  	crat_table->total_entries = 0;
> >  	crat_table->num_domains = 0;
> >  
> > -	sub_type_hdr = (struct crat_subtype_generic *)(crat_table+1);
> > -
> >  	for_each_online_node(numa_node_id) {
> >  		if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
> >  			continue;
> >  
> >  		/* Fill in Subtype: Compute Unit */
> > -		ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
> > -			crat_table->num_domains,
> > -			(struct crat_subtype_computeunit *)sub_type_hdr);
> > +		ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size, crat_table);
> >  		if (ret < 0)
> >  			return ret;
> > -		crat_table->length += sub_type_hdr->length;
> > -		crat_table->total_entries++;
> > -
> > -		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
> > -			sub_type_hdr->length);
> >  
> >  		/* Fill in Subtype: Memory */
> > -		ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
> > -			crat_table->num_domains,
> > -			(struct crat_subtype_memory *)sub_type_hdr);
> > +		ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size, crat_table);
> >  		if (ret < 0)
> >  			return ret;
> > -		crat_table->length += sub_type_hdr->length;
> > -		crat_table->total_entries++;
> > -
> > -		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
> > -			sub_type_hdr->length);
> >  
> >  		/* Fill in Subtype: IO Link */
> >  #ifdef CONFIG_X86_64
> > -		ret = kfd_fill_iolink_info_for_cpu(numa_node_id, &avail_size,
> > -				&entries,
> > -				(struct crat_subtype_iolink *)sub_type_hdr);
> > +		ret = kfd_fill_iolink_info_for_cpu(numa_node_id, &avail_size, crat_table);
> >  		if (ret < 0)
> >  			return ret;
> > -		crat_table->length += (sub_type_hdr->length * entries);
> > -		crat_table->total_entries += entries;
> > -
> > -		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
> > -				sub_type_hdr->length * entries);
> >  #else
> >  		pr_info("IO link not available for non x86 platforms\n");
> >  #endif
> 

