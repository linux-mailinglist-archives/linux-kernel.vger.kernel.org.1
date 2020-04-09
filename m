Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1D8C1A2F15
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 08:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgDIGSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 02:18:48 -0400
Received: from verein.lst.de ([213.95.11.211]:45306 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgDIGSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:18:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7A3A668C4E; Thu,  9 Apr 2020 08:18:46 +0200 (CEST)
Date:   Thu, 9 Apr 2020 08:18:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Wei Liu <wei.liu2@citrix.com>
Cc:     Bob Liu <bob.liu@oracle.com>,
        Paul Durrant <paul.durrant@citrix.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Use of VM_IOREMAP in xenbus
Message-ID: <20200409061846.GA30241@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

commit ccc9d90a9a8b5 ("xenbus_client: Extend interface to support
multi-page ring") addes a use of vmap in what is now
xenbus_map_ring_valloc_hvm, and uses the VM_IOREMAP flag that is
only really intended for implementing ioremap.  Do you remember
what the reason is that this flag was used?

