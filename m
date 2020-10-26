Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D6C2986DD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 07:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770400AbgJZGai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 02:30:38 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50729 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1770393AbgJZGai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 02:30:38 -0400
Received: by mail-pj1-f67.google.com with SMTP id p21so2650457pju.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 23:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KpIpUmt69QaoLNTIdy0Z4D8CvkXCXfbNd+RHrNHhrUo=;
        b=fCBKCdO7VXgNiv8zE92LqexyqnV/K7u5hMuA8HEpF8pBaRj5WyNc2VfwpdyKaBDAWE
         DAs2GMsbkrSUC29vh706y2ljm3iBiG6QwJu4fycMElpzOrzFSjRgiP6viYOE2FRRFk0e
         8oIgbc5xgqAmk+H6IR1nIxeHEVBsX3meA4htbDT5IKoRMYJDJVrPvoK2lrUqtTRgAA7n
         gwac+mb7PbFK2T7QF1Jnaz0EcAX0V3tOP2fOyhwq7hIzi7E6QsszIDLKEnwyY87iCSoB
         lBz/sKiFnp+sKqostTpL/ccMgaHYLvLj/vXIk8a/F+LTVzsvFXyiOLPnpfK2guWtWIof
         tNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KpIpUmt69QaoLNTIdy0Z4D8CvkXCXfbNd+RHrNHhrUo=;
        b=DcjlMvN0G6XMi9CIZhF18svNTIRlTWjXgiWIcL5C120uC0/PXfwRLJB34R3Xscf3l+
         i+73QHWYLKDgeuT/dpAEuVSVB6PTEYgVk7q8Sg/yJfEo10r+away+ThGOdBNWTMPisJV
         G+wKrlfZrHp9PvVI8sZ8g+/uwVHTLOd8ZQ3zGqSjtjecW99TbT7/l0/kBHJ5FjHXwlyI
         EbvAjgrvSf6RMXdeFkqiWt11K/DFxTDKHw29qLWv3ND1JuLgmHPrqBRqOnJsFRg8tqQi
         VwWO4AsIdpFN3mQdOsYrOuLsTwq+BYSviM+6bv23eTcJ6UjzEtJEy1Ahj1BBoLg8Gq+X
         GRhQ==
X-Gm-Message-State: AOAM531smcb30MV50KTD4stV+K8meHfJ/bEaxwF7/WfCQPZQhVEGvQ5j
        +aIRn3HSZ3nuh+//SPvBo4pAuw==
X-Google-Smtp-Source: ABdhPJytm1cZHJC+gD1AWOTVTUicvN3oEpYRnZMQ+flXAwym3y3ZrveeyRnN5yFuoTnpmeos5NrSvw==
X-Received: by 2002:a17:90b:19c9:: with SMTP id nm9mr14907331pjb.6.1603693837098;
        Sun, 25 Oct 2020 23:30:37 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id v24sm9585955pgi.91.2020.10.25.23.30.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Oct 2020 23:30:36 -0700 (PDT)
Date:   Mon, 26 Oct 2020 14:30:29 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/20] perf arm-spe: Refactor address packet handling
Message-ID: <20201026063029.GA32667@leoy-ThinkPad-X240s>
References: <20201022145816.14069-1-leo.yan@linaro.org>
 <20201022145816.14069-10-leo.yan@linaro.org>
 <388f90e9-baa0-33e9-f682-e9e9cd551cf4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <388f90e9-baa0-33e9-f682-e9e9cd551cf4@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 06:53:35PM +0100, André Przywara wrote:
> On 22/10/2020 15:58, Leo Yan wrote:
> 
> Hi Leo,
> 
> > This patch is to refactor address packet handling, it defines macros for
> > address packet's header and payload, these macros are used by decoder
> > and the dump flow.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  .../util/arm-spe-decoder/arm-spe-decoder.c    | 29 ++++++++--------
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 26 +++++++-------
> >  .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 34 ++++++++++++-------
> >  3 files changed, 47 insertions(+), 42 deletions(-)
> > 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > index cc18a1e8c212..776b3e6628bb 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > @@ -24,36 +24,35 @@
> >  
> >  static u64 arm_spe_calc_ip(int index, u64 payload)
> >  {
> > -	u8 *addr = (u8 *)&payload;
> > -	int ns, el;
> > +	u64 ns, el;
> >  
> >  	/* Instruction virtual address or Branch target address */
> >  	if (index == SPE_ADDR_PKT_HDR_INDEX_INS ||
> >  	    index == SPE_ADDR_PKT_HDR_INDEX_BRANCH) {
> > -		ns = addr[7] & SPE_ADDR_PKT_NS;
> > -		el = (addr[7] & SPE_ADDR_PKT_EL_MASK) >> SPE_ADDR_PKT_EL_OFFSET;
> > +		ns = SPE_ADDR_PKT_GET_NS(payload);
> > +		el = SPE_ADDR_PKT_GET_EL(payload);
> > +
> > +		/* Clean highest byte */
> > +		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
> >  
> >  		/* Fill highest byte for EL1 or EL2 (VHE) mode */
> >  		if (ns && (el == SPE_ADDR_PKT_EL1 || el == SPE_ADDR_PKT_EL2))
> > -			addr[7] = 0xff;
> > -		/* Clean highest byte for other cases */
> > -		else
> > -			addr[7] = 0x0;
> > +			payload |= 0xffULL << SPE_ADDR_PKT_ADDR_BYTE7_SHIFT;
> >  
> >  	/* Data access virtual address */
> >  	} else if (index == SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT) {
> >  
> > +		/* Clean tags */
> > +		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
> > +
> >  		/* Fill highest byte if bits [48..55] is 0xff */
> 
> Do you know where this comes from? If yes, can you replace the comment
> with the reason, so that it says *why* and not *what* the code does?

I think I know where this comes from :)

Armv8 ARM defines the Address packet payload, the data virtual address
highest byte (byte7 for bits [63:56]) is assignment for TAG; if connect
with the kernel document Documentation/arm64/memory.rst, we can see the
prededined the "AArch64 Linux memory layout with 4KB pages + 4 levels",
though the payload's byte7 is for TAG, but we can check bits [48..55]
(byte6) and if it's 0xff, then we need fill the byte7 so can create a
valid virtual address for data accessing, this finally can allow perf
tool to find correct symbol for data structure.

  Start                 End                     Size            Use                      
  -----------------------------------------------------------------------                
  0000000000000000      0000ffffffffffff         256TB          user                     
  ffff000000000000      ffff7fffffffffff         128TB          kernel logical memory map
  ffff800000000000      ffff9fffffffffff          32TB          kasan shadow region      
  ffffa00000000000      ffffa00007ffffff         128MB          bpf jit region           
  ffffa00008000000      ffffa0000fffffff         128MB          modules                  
  ffffa00010000000      fffffdffbffeffff         ~93TB          vmalloc                  
  fffffdffbfff0000      fffffdfffe5f8fff        ~998MB          [guard region]           
  fffffdfffe5f9000      fffffdfffe9fffff        4124KB          fixed mappings           
  fffffdfffea00000      fffffdfffebfffff           2MB          [guard region]           
  fffffdfffec00000      fffffdffffbfffff          16MB          PCI I/O space            
  fffffdffffc00000      fffffdffffdfffff           2MB          [guard region]           
  fffffdffffe00000      ffffffffffdfffff           2TB          vmemmap                  
  ffffffffffe00000      ffffffffffffffff           2MB          [guard region]           

But I find it misses to support the "AArch64 Linux memory layout with
64KB pages + 3 levels (52-bit with HW support)":

  Start                 End                     Size            Use                      
  -----------------------------------------------------------------------                
  0000000000000000      000fffffffffffff           4PB          user                     
  fff0000000000000      fff7ffffffffffff           2PB          kernel logical memory map
  fff8000000000000      fffd9fffffffffff        1440TB          [gap]                    
  fffda00000000000      ffff9fffffffffff         512TB          kasan shadow region      
  ffffa00000000000      ffffa00007ffffff         128MB          bpf jit region           
  ffffa00008000000      ffffa0000fffffff         128MB          modules                  
  ffffa00010000000      fffff81ffffeffff         ~88TB          vmalloc                  
  fffff81fffff0000      fffffc1ffe58ffff          ~3TB          [guard region]           
  fffffc1ffe590000      fffffc1ffe9fffff        4544KB          fixed mappings           
  fffffc1ffea00000      fffffc1ffebfffff           2MB          [guard region]           
  fffffc1ffec00000      fffffc1fffbfffff          16MB          PCI I/O space            
  fffffc1fffc00000      fffffc1fffdfffff           2MB          [guard region]           
  fffffc1fffe00000      ffffffffffdfffff        3968GB          vmemmap                  
  ffffffffffe00000      ffffffffffffffff           2MB          [guard region]           

So if detect byte6 is "0xf0", "0xf8, "0xfd", we also need to fixup the
byte7 and fill 0xff to it.

If you think this is right way to process address packet, I will use a
separate to fix comment and support 64KB page fixup.

> > -		if (addr[6] == 0xff)
> > -			addr[7] = 0xff;
> > -		/* Otherwise, cleanup tags */
> > -		else
> > -			addr[7] = 0x0;
> > +		if (SPE_ADDR_PKT_ADDR_GET_BYTE_6(payload) == 0xffULL)
> > +			payload |= 0xffULL << SPE_ADDR_PKT_ADDR_BYTE7_SHIFT;
> >  
> >  	/* Data access physical address */
> >  	} else if (index == SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS) {
> > -		/* Cleanup byte 7 */
> > -		addr[7] = 0x0;
> > +		/* Clean highest byte */
> > +		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
> >  	} else {
> >  		pr_err("unsupported address packet index: 0x%x\n", index);
> >  	}
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > index 550cd7648c73..156f98d6b8b2 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > @@ -13,9 +13,6 @@
> >  
> >  #include "arm-spe-pkt-decoder.h"
> >  
> > -#define NS_FLAG		BIT(63)
> > -#define EL_FLAG		(BIT(62) | BIT(61))
> > -
> >  #if __BYTE_ORDER == __BIG_ENDIAN
> >  #define le16_to_cpu bswap_16
> >  #define le32_to_cpu bswap_32
> > @@ -167,10 +164,11 @@ static int arm_spe_get_addr(const unsigned char *buf, size_t len,
> >  			    const unsigned char ext_hdr, struct arm_spe_pkt *packet)
> >  {
> >  	packet->type = ARM_SPE_ADDRESS;
> > +
> >  	if (ext_hdr)
> > -		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
> > +		packet->index = SPE_ADDR_PKT_HDR_EXTENDED_INDEX(buf[0], buf[1]);
> >  	else
> > -		packet->index = buf[0] & 0x7;
> > +		packet->index = SPE_ADDR_PKT_HDR_SHORT_INDEX(buf[0]);
> >  
> >  	return arm_spe_get_payload(buf, len, ext_hdr, packet);
> >  }
> > @@ -274,20 +272,20 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
> >  	u64 payload = packet->payload;
> >  
> >  	switch (idx) {
> > -	case 0:
> > -	case 1:
> > -		ns = !!(packet->payload & NS_FLAG);
> > -		el = (packet->payload & EL_FLAG) >> 61;
> > -		payload &= ~(0xffULL << 56);
> > +	case SPE_ADDR_PKT_HDR_INDEX_INS:
> > +	case SPE_ADDR_PKT_HDR_INDEX_BRANCH:
> > +		ns = !!SPE_ADDR_PKT_GET_NS(payload);
> > +		el = SPE_ADDR_PKT_GET_EL(payload);
> > +		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
> >  		return arm_spe_pkt_snprintf(&buf, &buf_len,
> >  				"%s 0x%llx el%d ns=%d",
> >  				(idx == 1) ? "TGT" : "PC", payload, el, ns);
> > -	case 2:
> > +	case SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT:
> >  		return arm_spe_pkt_snprintf(&buf, &buf_len,
> >  					    "VA 0x%llx", payload);
> > -	case 3:
> > -		ns = !!(packet->payload & NS_FLAG);
> > -		payload &= ~(0xffULL << 56);
> > +	case SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS:
> > +		ns = !!SPE_ADDR_PKT_GET_NS(payload);
> > +		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
> >  		return arm_spe_pkt_snprintf(&buf, &buf_len,
> >  					    "PA 0x%llx ns=%d", payload, ns);
> >  	default:
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > index 68552ff8a8f7..4111550d2bde 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > @@ -59,19 +59,27 @@ struct arm_spe_pkt {
> >  
> >  #define SPE_HEADER_SZ(val)			((val & GENMASK_ULL(5, 4)) >> 4)
> >  
> > -#define SPE_ADDR_PKT_HDR_INDEX_INS		(0x0)
> > -#define SPE_ADDR_PKT_HDR_INDEX_BRANCH		(0x1)
> > -#define SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT	(0x2)
> > -#define SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS	(0x3)
> > -
> > -#define SPE_ADDR_PKT_NS				BIT(7)
> > -#define SPE_ADDR_PKT_CH				BIT(6)
> > -#define SPE_ADDR_PKT_EL_OFFSET			(5)
> > -#define SPE_ADDR_PKT_EL_MASK			(0x3 << SPE_ADDR_PKT_EL_OFFSET)
> > -#define SPE_ADDR_PKT_EL0			(0)
> > -#define SPE_ADDR_PKT_EL1			(1)
> > -#define SPE_ADDR_PKT_EL2			(2)
> > -#define SPE_ADDR_PKT_EL3			(3)
> > +/* Address packet header */
> > +#define SPE_ADDR_PKT_HDR_SHORT_INDEX(h)		((h) & GENMASK_ULL(2, 0))
> > +#define SPE_ADDR_PKT_HDR_EXTENDED_INDEX(h0, h1)	(((h0) & GENMASK_ULL(1, 0)) << 3 | \
> > +						 SPE_ADDR_PKT_HDR_SHORT_INDEX(h1))
> 
> Did you consider sharing those two with the identical definition for the
> extended counter packet? This extended packet seems more like a generic
> concept, regardless of the packet type.

TBH, I have considered for this :)  An exception is the Context packet,
it uses different format for index (bits [1:0]).

I think I can consolidate the index for Address packet and conter
packet for sharing definitions.

  #define SPE_PKT_HDR_SHORT_INDEX(h)		((h) & GENMASK_ULL(2, 0))
  #define SPE_PKT_HDR_EXTENDED_INDEX(h0, h1)	(((h0) & GENMASK_ULL(1, 0)) << 3 | \
  						 SPE_PKT_HDR_SHORT_INDEX(h1))

> > +#define SPE_ADDR_PKT_HDR_INDEX_INS		0x0
> > +#define SPE_ADDR_PKT_HDR_INDEX_BRANCH		0x1
> > +#define SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT	0x2
> > +#define SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS	0x3
> > +
> > +/* Address packet payload */
> > +#define SPE_ADDR_PKT_ADDR_BYTE7_SHIFT		56
> > +#define SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(v)	((v) & GENMASK_ULL(55, 0))
> > +#define SPE_ADDR_PKT_ADDR_GET_BYTE_6(v)		(((v) & GENMASK_ULL(55, 48)) >> 48)
> > +
> > +#define SPE_ADDR_PKT_GET_NS(v)			(((v) & BIT(63)) >> 63)
> 
> You need BIT_ULL(63) here to make this work on 32-bit systems.

Will do.  Thanks!

Leo
