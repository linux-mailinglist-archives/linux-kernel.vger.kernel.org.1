Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2CD21E7D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 08:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgGNGCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 02:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgGNGCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:02:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D870D21D93;
        Tue, 14 Jul 2020 06:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594706560;
        bh=QdaFBpDRGpizTzOQaQSCq0rsbtp195RVw7IgKPGdycg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KQSMa+VKG6cmXxYmbWcOmhW45JT/mB6y5x2wBTHQbfFeO8Zapfl0K9IEnKO4N/urg
         WMqRO4abFXbvDRk8qJtUkMPUSRQML/qiZFL/lID4256toy0KYb2kJHX0ZlD4Qn8Yf1
         Pvei3dwlHlyC6odSWabPDwCIN1T2X+ex0WLCd11c=
Date:   Tue, 14 Jul 2020 08:02:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tcpm: Error handling for
 tcpm_register_partner_altmodes
Message-ID: <20200714060238.GA657428@kroah.com>
References: <20200714033453.4044482-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714033453.4044482-1-kyletso@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:34:51AM +0800, Kyle Tso wrote:
> *** BLURB HERE ***

No blurb?

:(
