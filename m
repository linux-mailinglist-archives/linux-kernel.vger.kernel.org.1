Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17342A9BF9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgKFSYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:24:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727765AbgKFSYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604687061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rpoIMYpAsT/EApk0aLEONLPpU9cBzDM2egfJxA+5bKs=;
        b=hpiy6ALtLsKrQUY31dHswITvYfqdXONUWoAcWiPU+sUU9gkimf0DpaeWGLaxL9vV+Cc5V+
        Vvfw9TaQCTgTqyo3MkUhQ7zDVMKkDFA7iwivDQ5J/7SW4EN6QD1uy89QRwUHYXq23GpUrM
        CHXzrJbWKnr1yIsYX7lQl/hNPq7s5EY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-rgTM4AR_Mc-x3FfPdto4wQ-1; Fri, 06 Nov 2020 13:24:18 -0500
X-MC-Unique: rgTM4AR_Mc-x3FfPdto4wQ-1
Received: by mail-qv1-f72.google.com with SMTP id r11so1196043qvn.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 10:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rpoIMYpAsT/EApk0aLEONLPpU9cBzDM2egfJxA+5bKs=;
        b=RPFtdU3pi2l+4EU8Be/yQUuVBmZrZ/mrBzY85bMGOZybDDWK+3Fh3WsVkAGWUK3whP
         mQ2ezGL5n7ozsqYL1Db0+jXA8dYHf1EBiuBiuTu9pJIC3AsCY5D6ka/4BJChF4BNKE0E
         qNerHPHWQ4x3v+ePagnVbZSGEdn+2dvfpuTawlaoLgv5by+OiR5dRn/+UgcsyFOFHevE
         glQ4Ef6eKnURI53M0QAT9/slegfiss1SA5inKDQbrCR88BJF0JjWluRBBuN8nWC4DS7g
         QnGQSXseV0eR+DByrVmeUHREh3EO4r+IXLTqTyI8sWWO0igCJXpEufwTbrlVLrNzJ1MW
         +tLw==
X-Gm-Message-State: AOAM530sWWvUQ3lJFENpeYfk/+UlO72QnbCu5Ls90jLvKodWrbo0wjPs
        tO6R699DkLdGJMDZk/eCiYEQqeS6bIn9IhU4Z3kSw9HMjaTHUbxkvOKIcqAdJtDVexjOGc6M0v3
        HepeiE9KjpIEqQU8chpNL4tvB
X-Received: by 2002:a05:6214:16d0:: with SMTP id d16mr2908321qvz.38.1604687058537;
        Fri, 06 Nov 2020 10:24:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjFRhUMcC6O0Xi4g7TUFBihyqqnSUi+JdTEDhbwl2AjXgP+c+ZnxTHtk1yMQni9Ih2fmcbHQ==
X-Received: by 2002:a05:6214:16d0:: with SMTP id d16mr2908305qvz.38.1604687058366;
        Fri, 06 Nov 2020 10:24:18 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
        by smtp.gmail.com with ESMTPSA id j7sm975327qtj.60.2020.11.06.10.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:24:17 -0800 (PST)
Date:   Fri, 6 Nov 2020 13:24:16 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: remove kvm_clear_guest_page
Message-ID: <20201106182416.GE138364@xz-x1>
References: <20201106102517.664773-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201106102517.664773-1-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 05:25:17AM -0500, Paolo Bonzini wrote:
> kvm_clear_guest_page is not used anymore after "KVM: X86: Don't track dirty
> for KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]", except from kvm_clear_guest.
> We can just inline it in its sole user.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

