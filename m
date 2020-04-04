Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B1E19E73C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 21:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgDDTAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Apr 2020 15:00:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42768 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgDDTAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 15:00:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id q19so10343551ljp.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 12:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YeDkwAMRYs+8ztmifHIoEPIXNMJQCvkCAGpkS5dmvN8=;
        b=Se6bVwp29Lk9h32ohyXnkTxpZWN2oAfGGVMd9atHYZHwssaXsgVFNMSGf5DdlCbS5n
         6oMYxUg+7Gpue3tjRTBS5k89CcsgtLlf71rBX1TwAMW2RoZyQ6FqPCmuVCnXoewymFwr
         u8+V2GzQKBi9LBHXE+i+WUEonct7JWKbF9uOLGAFPcxz/w5tqvXSsh5bJ2QSnNb/8xkJ
         CktrwX+nNwrI50JmXZzyqCqgE4gdaweoPfW9MysIEhaLZKxZJrfXXq8wukhQKtvBR8UY
         e4Z4+lFcL9gkfyE3SXe+R69AUCZGXnq9OAx8sH1b/+xvqhgGUG72/UY/Z2MQ1iYTTBl4
         NoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YeDkwAMRYs+8ztmifHIoEPIXNMJQCvkCAGpkS5dmvN8=;
        b=S7g02SqyPde9iZ2P1DNQsQKm/u9OcDMGGAJDnRi4kBwFQ4Zw/xa875X2KpXwuu6PkS
         Kp0SjZMyUoclodGrRlGV4M3cNoHbDZ8EJaIYlO4Ebdsr0Hr5kWTAUeWH4FQw9HCcrCRA
         evbYBpjmieY2IZdBpYOvBXBwLuNKXf+lScxWihRt5Qi7dnB3EUsTA0YbBtAWRtHVpuCL
         dUPv1x0g58xU2c3WSRjp4FFkYg3hP3ViG6+Q0cLRJqJ30/sO9fpStNipTCYSpZ/jL3Dy
         ZGnPaS7hvxB3gjNF3b9XewPcQp/E0qwRdNsseSCHmMjX81X4mwzTGO80elY1P8dKD//T
         PuTw==
X-Gm-Message-State: AGi0PuZjBswJTLq4GqhxTrKXd8X+45s5WNfZbAoRlneN5HnMvvo+x27T
        7ngv5uWmjDFy2RijBJej09Y=
X-Google-Smtp-Source: APiQypKQao45kx5IAtNq8FzqB2IyR/T1wX8CRcNWAOFeyv7EXc1A4vq3Xc8Q6zeR4/1eKhFwlFJs+A==
X-Received: by 2002:a2e:98d7:: with SMTP id s23mr7671487ljj.154.1586026814726;
        Sat, 04 Apr 2020 12:00:14 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id d6sm10327196lfn.72.2020.04.04.12.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 12:00:13 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sat, 4 Apr 2020 21:00:07 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jroedel@suse.de,
        vbabka@suse.cz, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm/vmalloc: Sanitize __get_vm_area() arguments
Message-ID: <20200404190007.GB424@pc636>
References: <20200403163253.GU20730@hirez.programming.kicks-ass.net>
 <20200403181818.GA5538@pc636>
 <20200403185300.GD20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403185300.GD20730@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 08:53:00PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 03, 2020 at 08:18:18PM +0200, Uladzislau Rezki wrote:
> > On Fri, Apr 03, 2020 at 06:32:53PM +0200, Peter Zijlstra wrote:
> > > 
> > > __get_vm_area() is an exported symbol, make sure the callers stay in
> > > the expected memory range. When calling this function with memory
> > > ranges outside of the VMALLOC range *bad* things can happen.
> > > 
> > > (I noticed this when I managed to corrupt the kernel text by accident)
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  mm/vmalloc.c |    7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -2130,6 +2130,13 @@ static struct vm_struct *__get_vm_area_n
> > >  struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
> > >  				unsigned long start, unsigned long end)
> > >  {
> > > +	/*
> > > +	 * Ensure callers stay in the vmalloc range.
> > > +	 */
> > > +	if (WARN_ON(start < VMALLOC_START || start > VMALLOC_END ||
> > > +		    end < VMALLOC_START || end > VMALLOC_END))
> > > +		return NULL;
> > > +
> > >  	return __get_vm_area_node(size, 1, flags, start, end, NUMA_NO_NODE,
> > >  				  GFP_KERNEL, __builtin_return_address(0));
> > >  }
> > Peter, could you please clarify what kind of issues you had and how you
> > tested?
> 
> Well, I had a bug and corrupted text; but then I tested:
> 
> 	__get_vm_area(PAGE_SIZE, VM_ALLOC, __START_KERNEL_map,
> 		      __START_KERNEL_map + KERNEL_IMAGE_SIZE);
> 
> and that *works*.
> 
Do you mean that you corrupted "text" by calling __get_vm_area(...)
with special parameters? If so could you please show how you used it.

> > __get_vm_area() is not limited by allocating only with vmalloc space,
> > it can use whole virtual address space/range, i.e. 1 - ULONG_MAX.
> 
> Yeah, I know, I'm saying it perhaps should be, because not limiting it
> while exposing it to modules seems risky at best, downright dangerous if
> you consider map_vm_area() is also exported.
> 
Doing it to secure modules, probably is OK, but modules can also be reside
within vmalloc address space.

Thank you in advance!

--
Vlad Rezki
