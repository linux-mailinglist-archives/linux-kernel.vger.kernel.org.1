Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1E12C3257
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 22:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgKXVI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 16:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbgKXVIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:08:25 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1879C061A4E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 13:08:23 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id 5so11321927plj.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 13:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G8S42ykz8GQE/h+DytjaAc53070LGayg6/X2MaLnGo4=;
        b=rsCmTT9AmQu1r6IL0afCU1Zq05tKOxlvyj55zg3e4zT5rVbfFAzSLQgCuoRaQFu7v1
         +kXtZGJWUWplCRgQf3TWQeCyNjjdvRtdAEaKGVx4/otabfhCDdgsO9E3hhc+BEAQlovK
         ECp6s3ALBjkJ2dmlobjtCpJCJgDkZRTNhu73PVHr/ems2HMqXhcwXxEBUn1DuhffMmYk
         O3Zi9AY50iDVUSy9NV4U/2qXROdtB0fYp9q/ZkXZCQR/DOB39OmRESUFJ8p3Wz6DOm5h
         0qOzDg2UcQEiXlHCSAsHLiPvIVMvu8zXyfFbOnBYwNvHcHLX3KTg6SkKzAZDN26Nqk1Y
         6h4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G8S42ykz8GQE/h+DytjaAc53070LGayg6/X2MaLnGo4=;
        b=tHc8XiXVTzIsBRJxD5RV/XGSb35tVTZUWsvlmVWtoCP2oYccHjRV7PFU0WQ0flhUtg
         czofs5svjl5puziIOsFhoGTkCG2aKntXVFi4DzeJIIAu5KZoZNsSOHFT6pKqWpcSW8Ib
         uDyhq0mw9EEkwLBYlAzgb469i34ZuyHMDeIB4XiA3STmrjAf6Igu6KFu6YVgHopKsolm
         N/HlMkIN8aQuDZ/VFXF8sdBhTWWqb3N+m7zSlPFYdXd7PPpTg2/efVo6VUwlIOP+kgsV
         RTh1+ZAV9ca1nLNX8z/cPPXxDNmFeEbgNqmWcb1y9P8wVVlONM9PWYVqVD1g9UJEvELB
         +R9A==
X-Gm-Message-State: AOAM530iLaTE9Pd9rc6nJpbqyJ1TX4zul0k82En/19mye/Y79uLqHfXR
        x8WfRReQBYgOJRA0u3fTsQofug==
X-Google-Smtp-Source: ABdhPJz5Fx2+bpGo/B/r0yfGYFv5y2+FYhmfiO8de2zRAtmGS5ARVTlePGqT5XUmBOcO4TzSzaVPsA==
X-Received: by 2002:a17:902:8b8c:b029:d6:df70:fa21 with SMTP id ay12-20020a1709028b8cb02900d6df70fa21mr147419plb.15.1606252102945;
        Tue, 24 Nov 2020 13:08:22 -0800 (PST)
Received: from google.com ([2620:0:1008:10:1ea0:b8ff:fe75:b885])
        by smtp.gmail.com with ESMTPSA id r15sm119898pjp.51.2020.11.24.13.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 13:08:22 -0800 (PST)
Date:   Tue, 24 Nov 2020 13:08:17 -0800
From:   Vipin Sharma <vipinsh@google.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas <thomas.lendacky@amd.com>, pbonzini@redhat.com,
        tj@kernel.org, lizefan@huawei.com, joro@8bytes.org, corbet@lwn.net,
        Brijesh <brijesh.singh@amd.com>, Jon <jon.grimm@amd.com>,
        Eric <eric.vantassell@amd.com>, gingell@google.com,
        kvm@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC Patch 0/2] KVM: SVM: Cgroup support for SVM SEV ASIDs
Message-ID: <20201124210817.GA65542@google.com>
References: <alpine.DEB.2.23.453.2011131615510.333518@chino.kir.corp.google.com>
 <20201124191629.GB235281@google.com>
 <20201124194904.GA45519@google.com>
 <alpine.DEB.2.23.453.2011241215400.3594395@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.23.453.2011241215400.3594395@chino.kir.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:18:45PM -0800, David Rientjes wrote:
> On Tue, 24 Nov 2020, Vipin Sharma wrote:
> 
> > > > Looping Janosch and Christian back into the thread.                           
> > > >                                                                               
> > > > I interpret this suggestion as                                                
> > > > encryption.{sev,sev_es,keyids}.{max,current,events} for AMD and Intel         
> > > 
> > > I think it makes sense to use encryption_ids instead of simply encryption, that
> > > way it's clear the cgroup is accounting ids as opposed to restricting what
> > > techs can be used on yes/no basis.
> > > 
> 
> Agreed.
> 
> > > > offerings, which was my thought on this as well.                              
> > > >                                                                               
> > > > Certainly the kernel could provide a single interface for all of these and    
> > > > key value pairs depending on the underlying encryption technology but it      
> > > > seems to only introduce additional complexity in the kernel in string         
> > > > parsing that can otherwise be avoided.  I think we all agree that a single    
> > > > interface for all encryption keys or one-value-per-file could be done in      
> > > > the kernel and handled by any userspace agent that is configuring these       
> > > > values.                                                                       
> > > >                                                                               
> > > > I think Vipin is adding a root level file that describes how many keys we     
> > > > have available on the platform for each technology.  So I think this comes    
> > > > down to, for example, a single encryption.max file vs                         
> > > > encryption.{sev,sev_es,keyid}.max.  SEV and SEV-ES ASIDs are provisioned      
> > > 
> > > Are you suggesting that the cgroup omit "current" and "events"?  I agree there's
> > > no need to enumerate platform total, but not knowing how many of the allowed IDs
> > > have been allocated seems problematic.
> > > 
> > 
> > We will be showing encryption_ids.{sev,sev_es}.{max,current}
> > I am inclined to not provide "events" as I am not using it, let me know
> > if this file is required, I can provide it then.
> > 
> > I will provide an encryption_ids.{sev,sev_es}.stat file, which shows
> > total available ids on the platform. This one will be useful for
> > scheduling jobs in the cloud infrastructure based on total supported
> > capacity.
> > 
> 
> Makes sense.  I assume the stat file is only at the cgroup root level 
> since it would otherwise be duplicating its contents in every cgroup under 
> it.  Probably not very helpful for child cgroup to see stat = 509 ASIDs 
> but max = 100 :)

Yes, only at root.
