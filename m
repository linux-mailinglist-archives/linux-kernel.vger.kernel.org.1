Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C3927F6D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 02:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732171AbgJAAmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 20:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731339AbgJAAmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 20:42:21 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601512940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1dZAHWtiKSMf8mYBi0q5UFXISwoH04KbR1oFeQ0MPNQ=;
        b=AA28nO6pNpydMLSZBYQBBnEDkzRVvxfuYEtCceEDkQdL3XmkV+DBn7nrp7zIZENUUspiyp
        UxPUoLIeBVX24JDV6SSys2iXStajMMyrhNW2sWgNxh+rZaBeelsZOKbrEoHaEueWlXQY6S
        knBkbiijs8Duc6lkHrQmrK06zPxprGA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-bP_o5P85PDO7x8eYEhtl-Q-1; Wed, 30 Sep 2020 20:42:18 -0400
X-MC-Unique: bP_o5P85PDO7x8eYEhtl-Q-1
Received: by mail-qv1-f71.google.com with SMTP id a13so2065334qvl.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 17:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1dZAHWtiKSMf8mYBi0q5UFXISwoH04KbR1oFeQ0MPNQ=;
        b=YvYCpTqIDjSBrlf/OFVYVvNiMgTs2QflFbUBmUqEIClS4ABGdCyzPrmUqqUEWqAMhc
         CYgi0I8v++3Ppnd0c1Y0qJFX1VY2B7zuH3vNkBRD9B3NP1xuJkcf0qVWEqjjwFQ9HoqD
         CpyYyW5XbS/gxISs+pwadYbqWa0B4yDKmU7QisEzDQnCqKDLoa4LX/JeN/v/fcWa+kmE
         JLnZrcA53XxVbjGxk4t8MzhFAE50KhKPGvCghWmMSa21+h4MhL6nl+U1NV2gRuyeFzbZ
         JoL0pLR//lzir1J6u2ugkqsx8q4AuWwmwDG9MpCtePl2yg8H4E55jwZRd7cQYLaMhUKh
         Euyw==
X-Gm-Message-State: AOAM531DQDVLTuXC7rrC2QdGTKsynPtsSKSTwIeEL5aIKsRC9GQU24el
        GK/K8TGQHqqGRyef2gf5uRx01V4JeakXZYjegJhQ6QzMRR2Ut4eVpijZh+B8zk2B2JcrvMlxUr2
        LvoMxUhOvdpJ/cY11ehos6v2o
X-Received: by 2002:a05:620a:b18:: with SMTP id t24mr5452568qkg.401.1601512937987;
        Wed, 30 Sep 2020 17:42:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIDSvnLGUwNL+2BLIEvn9OGWviDasq6qOhSb244j0gvhx6q/5RSZ+zbvBvAe8dG2VfZreS1Q==
X-Received: by 2002:a05:620a:b18:: with SMTP id t24mr5452548qkg.401.1601512937723;
        Wed, 30 Sep 2020 17:42:17 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id y46sm4602375qtc.30.2020.09.30.17.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 17:42:17 -0700 (PDT)
Date:   Wed, 30 Sep 2020 20:42:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v12 00/13] KVM: Dirty ring interface
Message-ID: <20201001004218.GA6063@xz-x1>
References: <20200930214948.47225-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930214948.47225-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 05:49:35PM -0400, Peter Xu wrote:
> - rebase

I made the same mistake again on rebasing to 5.9-rc7 rather than kvm/queue.
Doing it again.  Sorry for the noise.

-- 
Peter Xu

