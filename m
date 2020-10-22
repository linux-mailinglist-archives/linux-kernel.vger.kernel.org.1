Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73ACC295F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899406AbgJVNOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2899395AbgJVNOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:14:15 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71D5824178;
        Thu, 22 Oct 2020 13:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603372454;
        bh=ewhdFI2cl7uU5ebPSxO7bSJrTEC5WCyZWiaEoBBCKPM=;
        h=Date:From:To:Subject:From;
        b=nEBcXe3wTi9iqECZGG+7yw0BCjZ7v1K8S7wakKe5QxlvBDTf7o4r1MRZ8bsqcZmu9
         bfKj3U0xDylGlnjnf0ZcdngN3ci7ia/bhjain+DpZisWDvIxObGo6m5UH7w8CSgoMT
         t9D213kFKSx+/k9JjzVnbUiZPNVECQEYkjXhxUaY=
Date:   Thu, 22 Oct 2020 15:14:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: usbutils 013 release
Message-ID: <20201022131451.GA1779379@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been a long time, and there have been a number of tiny bugfixes in
the usbutils package backing up, as well as one major issue finally
fixed that had been reported a lot, so it's time for a new release.

One other "major" change is we now trust sysfs to have the string values
for the vendor/product descriptors, instead of having to ask the device
directly for them.  That should save a bit of USB bandwidth, but for
containers that have sysfs blocked off, this might cause some problems.
If so, please let me know.

Tarballs can be found on kernel.org here:
	https://www.kernel.org/pub/linux/utils/usb/usbutils/

Or the github/kernel.org repo also have the updated trees:
	https://github.com/gregkh/usbutils
	https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usbutils.git

and the full shortlog is below.

thanks,

greg k-h

------------

usbutils 013
============

Aurelien Jarno (1):
      lsusb.8.in: do not mention usb.ids

Baruch Siach (1):
      usb-devices.1: don't mention bash

Greg Kroah-Hartman (15):
      usbhid-dump: move manpage to main directory out of subdir
      usbhid-dump.8: add SPDX header
      usbhid-dump.8: autogenerate it with the usbutils version number
      .gitignore: add usbhid-dump.8
      usbhid-dump: add SPDX identifiers to all files.
      usbhid-dump: remove libusb.h libusb_strerror() implementation
      usbhid-dump: remove lib directory
      usbhid-dump: move .h files into src/ directory
      Makefile.am: add usbhid-dump.8 to distclean list
      usbhid-dump: some autoconf cleanup
      usbhid-dump: remove some dev_list functions that were never used
      dump_audiostreaming_interface(): remove unused variable
      usbmisc: initialize string buffer before reading from device.
      lsusb.py: drop trailing space on non-hub devices
      lsusb.py: strip whitespace from device strings

Jakub Wilk (2):
      lsusb(8): fix formatting
      lsusb(8): document --tree

Pino Toscano (1):
      lsusb.py: remove private paths for usb.ids

Rob Gill (1):
      Additional device classes for usb-devices script

Rosen Penev (1):
      usbhid-dump: Do not use rindex

Thomas Hebb (4):
      Move read_sysfs_prop() from names.c to its own file
      sysfs: Don't return bogus data for devices under a hub
      lsusb: Use vendor and product name fallback logic in -D mode too
      lsusb: Get manufacturer, product, and serial from sysfs

Timothy Robert Bednarzyk (1):
      bootstrap: change /bin/bash to /bin/sh

Torleiv Sundre (1):
      lsusb: fix two typos in UVC Extension Unit descriptor

Tormod Volden (1):
      usbhid-dump: Put back autoconf check for libusb_set_option()
