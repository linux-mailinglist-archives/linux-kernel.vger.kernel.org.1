Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB4C91A3656
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 16:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgDIOzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 10:55:21 -0400
Received: from mail.xenproject.org ([104.130.215.37]:40796 "EHLO
        mail.xenproject.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgDIOzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:55:20 -0400
X-Greylist: delayed 1617 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Apr 2020 10:55:20 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
        s=20200302mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=88CLnI9d7vqlxpuj08ZyNiGa+C1+B5g5kceeRwldYQw=; b=po8LC+iHiziy3E2x/Sb34Szt44
        iStb7gSnx4kP/LR9uZ+C2vryyP6l98PNHg54l8mzGKJORo1GC7Dl6jHR3cTCFKvbnJZY72/dZhAR4
        w8fdyOBDM8fhMhaDd4yJNPaUl23wnaPUU6iM0ZN92lVm/ppPnP/rGK4KXDrHgdMMLsPk=;
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.89)
        (envelope-from <wl@xen.org>)
        id 1jMYAC-0007As-PA; Thu, 09 Apr 2020 14:28:16 +0000
Received: from 44.142.6.51.dyn.plus.net ([51.6.142.44] helo=debian)
        by xenbits.xenproject.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <wl@xen.org>)
        id 1jMYAC-00041C-Ep; Thu, 09 Apr 2020 14:28:16 +0000
Date:   Thu, 9 Apr 2020 15:28:13 +0100
From:   Wei Liu <wl@xen.org>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Wei Liu <wl@xen.org>,
        Bob Liu <bob.liu@oracle.com>,
        "Durrant, Paul" <pdurrant@amazon.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: Use of VM_IOREMAP in xenbus
Message-ID: <20200409142813.lbxembj7b63b2wmi@debian>
References: <20200409061846.GA30241@lst.de>
 <8074b77d-d784-95ee-8d47-069827855876@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8074b77d-d784-95ee-8d47-069827855876@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

On Thu, Apr 09, 2020 at 08:37:48AM +0200, Jürgen Groß wrote:
> Adjusting recipient list (dropping David, new mail addresses for Wei and
> Paul).
> 
> On 09.04.20 08:18, Christoph Hellwig wrote:
> > Hi Wei,
> > 
> > commit ccc9d90a9a8b5 ("xenbus_client: Extend interface to support
> > multi-page ring") addes a use of vmap in what is now
> > xenbus_map_ring_valloc_hvm, and uses the VM_IOREMAP flag that is
> > only really intended for implementing ioremap.  Do you remember
> > what the reason is that this flag was used?
> > 

I don't remember the reason. I can that flag can be dropped per your
reasoning.

Wei.

> 
> Juergen
