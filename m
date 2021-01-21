Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7262FF4C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbhAUTkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:40:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbhAUTkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:40:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA36523A3A;
        Thu, 21 Jan 2021 19:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611257968;
        bh=Z9FRsLteP/J/cHt9/h/jTIJq/qY7J3kx03wftfOeQ8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=alVUVTNMq1gJfKNjkRD1C52klNQoL5BlzSBK8LeE1jSkWiyw6IyxAnN3Wd+QkikJU
         ObvyO23G26e2urv6VOqw173p4oGNoWn2NxcgwyPAv0gRnN6qrgZCxtQ1uqoJD6nNTQ
         DjtT9FEJhsP8zBlScIotY72vVnTdHTFyTP+v7T98=
Date:   Thu, 21 Jan 2021 20:39:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.11-rc5
Message-ID: <YAnYaa4kWdLfZms9@kroah.com>
References: <20210121192514.GA5598@CORE.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121192514.GA5598@CORE.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 09:25:14PM +0200, Oded Gabbay wrote:
> Hi Greg,
> 
> This pull request contains three important bug fixes for 5.11-rc5.
> One of the fixes prevent a possible host machine crash, another
> one prevents random card reset and the third adds a missing
> backward compatibility to a uapi. More details are in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit cb5c681ab9037e25fcca20689c82cf034566d610:
> 
>   intel_th: pci: Add Alder Lake-P support (2021-01-21 18:54:43 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2021-01-21

Pulled and pushed out, thanks.

greg k-h
