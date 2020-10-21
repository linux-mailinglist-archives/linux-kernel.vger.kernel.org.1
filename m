Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80BE2950B9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437996AbgJUQ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730602AbgJUQ2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:28:55 -0400
Received: from coco.lan (ip5f5ad5a8.dynamic.kabel-deutschland.de [95.90.213.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC58720870;
        Wed, 21 Oct 2020 16:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603297733;
        bh=JEj8379nMCU3yktHviIckNnQtk45Avq6ZL58P70Kuzc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=okhvgAZIK3l+ezdLV9hgu5Vg7qhQyE3rGlYXY9vBonicbrl6mZbArb4smLYppblxi
         68/Q9CksnOoyBoYDXxPbVlutXVvsq8t6Nk44/p9veEDa9y4Po48tSXSnxS2ClmPEfg
         Lx5JKf5ed4LSx/bwYdWd1n3oq6+QHN0dR0JYSMdk=
Date:   Wed, 21 Oct 2020 18:28:43 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Akira Shimahara <akira215corp@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Evgeny Boger <boger@wirenboard.com>
Subject: Adding ABI to htmldocs - Was: Re: [PATCH 2/2] w1: w1_therm: Add
 support for GXCAS GX20MH01 device.
Message-ID: <20201021182843.522dd7e7@coco.lan>
In-Reply-To: <20201007135934.4b6e598e@coco.lan>
References: <20200904160004.87710-1-ivan.zaentsev@wirenboard.ru>
        <20200904160004.87710-2-ivan.zaentsev@wirenboard.ru>
        <20201006151915.77d044a4@coco.lan>
        <1561045277.20201007103227@wirenboard.ru>
        <20201007105702.67988846@coco.lan>
        <20201007090619.GA613204@kroah.com>
        <20201007130549.6ca57af0@coco.lan>
        <20201007114359.GA2167293@kroah.com>
        <20201007135934.4b6e598e@coco.lan>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi greg,

Em Wed, 7 Oct 2020 13:59:34 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Wed, 7 Oct 2020 13:43:59 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> 
> > On Wed, Oct 07, 2020 at 01:05:49PM +0200, Mauro Carvalho Chehab wrote:  
> > > Em Wed, 7 Oct 2020 11:06:19 +0200
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> > >     
> > > > On Wed, Oct 07, 2020 at 10:57:02AM +0200, Mauro Carvalho Chehab wrote:    
> > > > > Em Wed, 7 Oct 2020 10:32:27 +0300
> > > > > Ivan Zaentsev <ivan.zaentsev@wirenboard.ru> escreveu:
> > > > >       
> > > > > > Tuesday, October 6, 2020, 4:19:15 PM, Mauro Carvalho Chehab wrote:
> > > > > >       
> > > > > > >> diff --git a/Documentation/w1/slaves/w1_therm.rst b/Documentation/w1/slaves/w1_therm.rst
> > > > > > >> index f1148181f53e..00376501a5ef 100644
> > > > > > >> --- a/Documentation/w1/slaves/w1_therm.rst
> > > > > > >> +++ b/Documentation/w1/slaves/w1_therm.rst        
> > > > > >       
> > > > > > >>  
> > > > > > >> @@ -130,4 +131,12 @@ conversion and temperature reads 85.00 (powerup value) or 127.94 (insufficient
> > > > > > >>  power), the driver returns a conversion error. Bit mask ``2`` enables poll for
> > > > > > >>  conversion completion (normal power only) by generating read cycles on the bus
> > > > > > >>  after conversion starts. In parasite power mode this feature is not available.
> > > > > > >> -Feature bit masks may be combined (OR).
> > > > > > >> +Feature bit masks may be combined (OR). See accompanying sysfs documentation:
> > > > > > >> +:ref:`Documentation/w1/slaves/w1_therm.rst <w1_therm>`
> > > > > > >> +        
> > > > > >       
> > > > > > > As warned by Sphinx, this cross-reference is broken:        
> > > > > >       
> > > > > > >         .../Documentation/w1/slaves/w1_therm.rst:125: WARNING:
> > > > > > > undefined label: w1_therm (if the link has no caption the label must precede a section header)        
> > > > > > 
> > > > > > Would this be ok?      
> > > > > 
> > > > > Yeah, sure!
> > > > >       
> > > > > > 
> > > > > > "More details in Documentation/ABI/testing/sysfs-driver-w1_therm"
> > > > > >       
> > > > > > > Not sure what you wanted to point here.        
> > > > > > 
> > > > > > A link to a driver's sysfs interface, but sysfs docs are text
> > > > > > files and seem to not be included in Sphynx Docs.      
> > > > > 
> > > > > I sent upstream sometime ago a patch series adding ABI to Sphinx, but I 
> > > > > was not merged, not sure why:
> > > > > 
> > > > > 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=abi_patches_v5.6      
> > > > 
> > > > I think the raft of different patches floating around at the time made
> > > > me totally confused as to what was, and was not, the latest versions.    
> > > 
> > > Yeah, there were lots of patches floating around that time.
> > > 
> > > I also recall that someone (Jeni?) asked if the best wouldn't be to
> > > just convert the ABI files to ReST directly.
> > >     
> > > > I'll be glad to look at them again, if you want to rebase after 5.10-rc1
> > > > is out and resend them, as I think this should be showing up in the
> > > > documentation.    
> > > 
> > > Surely. I'll rebase them after 5.10-rc1 and re-submit. 
> > > 
> > > What strategy do you prefer? Keep the files with the same format as
> > > today (allowing them to optionally have ReST markups) or to convert
> > > them to .rst directly?
> > > 
> > > In the latter case, the best would be to apply it as early as possible
> > > after 5.10-rc1, as it may cause conflicts with other patches being
> > > submitted for 5.11.    
> > 
> > The existing format if at all possible, doing wholesale changes is a
> > mess and wouldn't be recommended.  
> 
> Yeah, merging it would indeed be a mess. At long term, though, it could 
> be easier to maintain.
> 
> > I think you already fixed up the entries that had problems being parsed
> > in the past, if not, we can resolve those as well.  
> 
> Yes. The series start with fixes. I suspect several of them
> (if not all) were already merged, but if anything is missing, I can fix 
> at the upcoming rebased series.

Rebasing the patch series was easier than what I expected:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=abi_patches_v6

Yet, while fixing one build issue, I noticed that there are multiple
files defining the same ABI, with different contents.

Right now, scripts/get_abi.pl assumes that "what" is unique. Well, sorts
of. When it finds a duplicated entry, it merges the description, 
preserving the fields from the last parsed entry.

I ended adding a patch to detect those ABI duplication:

	https://git.linuxtv.org/mchehab/experimental.git/commit/?h=abi_patches_v6&id=6868914605cb0ebffe3fd07d344c246e1e4cd94e

I'm enclosing the results.

One such example is this one:

	3 duplicated entries for /sys/class/leds/<led>/hw_pattern: on file(s) sysfs-class-led-trigger-pattern sysfs-class-led-driver-sc27xx sysfs-class-led-driver-el15203000

It sounds that different drivers define and use this ABI, but
each one with different meanings. 

There are even some cases where the same file define the same ABI twice:

	2 duplicated entries for /sys/class/power_supply/<supply_name>/temp_alert_min: on file(s) sysfs-class-power

Not sure what's the best way to document things like that, or if
the fix would be to drop/merge those.

Any ideas?

Thanks,
Mauro

$ ./scripts/get_abi.pl validate
2 duplicated entries for /sys/class/infiniband/<device>/ports/<port-num>/counters/symbol_error, /sys/class/infiniband/<device>/ports/<port-num>/counters/port_rcv_errors, /sys/class/infiniband/<device>/ports/<port-num>/counters/port_rcv_remote_physical_errors, /sys/class/infiniband/<device>/ports/<port-num>/counters/port_rcv_switch_relay_errors, /sys/class/infiniband/<device>/ports/<port-num>/counters/link_error_recovery, /sys/class/infiniband/<device>/ports/<port-num>/counters/port_xmit_constraint_errors, /sys/class/infiniband/<device>/ports/<port-num>/counters/port_rcv_contraint_errors, /sys/class/infiniband/<device>/ports/<port-num>/counters/local_link_integrity_errors, /sys/class/infiniband/<device>/ports/<port-num>/counters/excessive_buffer_overrun_errors, /sys/class/infiniband/<device>/ports/<port-num>/counters/port_xmit_data, /sys/class/infiniband/<device>/ports/<port-num>/counters/port_rcv_data, /sys/class/infiniband/<device>/ports/<port-num>/counters/port_xmit_packets, /sys/c
 lass/infiniband/<device>/ports/<port-num>/counters/port_rcv_packets, /sys/class/infiniband/<device>/ports/<port-num>/counters/unicast_rcv_packets, /sys/class/infiniband/<device>/ports/<port-num>/counters/unicast_xmit_packets, /sys/class/infiniband/<device>/ports/<port-num>/counters/multicast_rcv_packets, /sys/class/infiniband/<device>/ports/<port-num>/counters/multicast_xmit_packets, /sys/class/infiniband/<device>/ports/<port-num>/counters/link_downed, /sys/class/infiniband/<device>/ports/<port-num>/counters/port_xmit_discards, /sys/class/infiniband/<device>/ports/<port-num>/counters/VL15_dropped, /sys/class/infiniband/<device>/ports/<port-num>/counters/port_xmit_wait: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/qibX/ports/N/sl2vl/[0-15]: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband_verbs/abi_version: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/backlight/<backlight>/ambient_light_zone: on file(s) sysfs-class-backlight-adp8860 sysfs-class-backlight-driver-adp8870
3 duplicated entries for /sys/class/leds/<led>/hw_pattern: on file(s) sysfs-class-led-trigger-pattern sysfs-class-led-driver-sc27xx sysfs-class-led-driver-el15203000
2 duplicated entries for /sys/bus/vmbus/devices/<UUID>/channels/<N>/cpu: on file(s) sysfs-bus-vmbus
2 duplicated entries for /sys/class/infiniband/qibX/ports/N/CCMgtA/cc_settings_bin, /sys/class/infiniband/qibX/ports/N/CCMgtA/cc_table_bin: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/hfi1_X/hw_rev, /sys/class/infiniband/hfi1_X/board_id, /sys/class/infiniband/hfi1_X/nctxts, /sys/class/infiniband/hfi1_X/serial, /sys/class/infiniband/hfi1_X/chip_reset, /sys/class/infiniband/hfi1_X/boardversion, /sys/class/infiniband/hfi1_X/nfreectxts, /sys/class/infiniband/hfi1_X/tempsense: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/<hca>/ports/<port-number>/gid_attrs/ndevs/<gid-index>: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/hfi1_X/sdma_N/cpu_list, /sys/class/infiniband/hfi1_X/sdma_N/vl: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/bus/iio/devices/iio:deviceX/out_currentY_raw: on file(s) sysfs-bus-iio-light-lm3533-als sysfs-bus-iio-health-afe440x
2 duplicated entries for /sys/class/infiniband/vmw_pvrdmaX/hw_rev, /sys/class/infiniband/vmw_pvrdmaX/hca_type, /sys/class/infiniband/vmw_pvrdmaX/board_id: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/ocrdmaX/hw_rev: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/mlx4_X/iov/<pci-slot-num>/ports/<m>/smi_enabled, /sys/class/infiniband/mlx4_X/iov/<pci-slot-num>/ports/<m>/enable_smi_admin: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/mlx4_X/iov/ports/<port-num>/gids/<n>, /sys/class/infiniband/mlx4_X/iov/ports/<port-num>/admin_guids/<n>, /sys/class/infiniband/mlx4_X/iov/ports/<port-num>/pkeys/<n>, /sys/class/infiniband/mlx4_X/iov/ports/<port-num>/mcgs/, /sys/class/infiniband/mlx4_X/iov/ports/<pci-slot-num>/ports/<m>/gid_idx/0, /sys/class/infiniband/mlx4_X/iov/ports/<pci-slot-num>/ports/<m>/pkey_idx/<n>: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/qibX/ports/N/linkstate/loopback, /sys/class/infiniband/qibX/ports/N/linkstate/led_override, /sys/class/infiniband/qibX/ports/N/linkstate/hrtbt_enable, /sys/class/infiniband/qibX/ports/N/linkstate/status, /sys/class/infiniband/qibX/ports/N/linkstate/status_str: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband_mad/umadN/ibdev, /sys/class/infiniband_mad/umadN/port, /sys/class/infiniband_mad/issmN/ibdev, /sys/class/infiniband_mad/issmN/port: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/power_supply/<supply_name>/temp_alert_max: on file(s) sysfs-class-power
2 duplicated entries for /sys/class/infiniband/mlx4_X/hw_rev, /sys/class/infiniband/mlx4_X/hca_type, /sys/class/infiniband/mlx4_X/board_id: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/<hca>/ports/<port-number>/gid_attrs/types/<gid-index>: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/power_supply/<supply_name>/current_max: on file(s) sysfs-class-power
2 duplicated entries for /sys/class/infiniband/<device>/ports/<port-num>/link_layer: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/qedrX/hw_rev, /sys/class/infiniband/qedrX/hca_type: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/power_supply/<supply_name>/current_avg: on file(s) sysfs-class-power
2 duplicated entries for /sys/class/infiniband/qibX/version, /sys/class/infiniband/qibX/hw_rev, /sys/class/infiniband/qibX/hca_type, /sys/class/infiniband/qibX/board_id, /sys/class/infiniband/qibX/boardversion, /sys/class/infiniband/qibX/nctxts, /sys/class/infiniband/qibX/localbus_info, /sys/class/infiniband/qibX/tempsense, /sys/class/infiniband/qibX/serial, /sys/class/infiniband/qibX/nfreectxts, /sys/class/infiniband/qibX/chip_reset: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/bus/iio/devices/iio:deviceX/sensor_sensitivity: on file(s) sysfs-bus-iio-distance-srf08 sysfs-bus-iio-proximity-as3935
2 duplicated entries for /sys/class/infiniband/usnic_X/qpn/summary, /sys/class/infiniband/usnic_X/qpn/context: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/kernel/iommu_groups/reserved_regions: on file(s) sysfs-kernel-iommu_groups
2 duplicated entries for /sys/class/power_supply/<supply_name>/temp_max: on file(s) sysfs-class-power
2 duplicated entries for /sys/class/infiniband_verbs/uverbsN/ibdev, /sys/class/infiniband_verbs/uverbsN/abi_version: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/bnxt_reX/hw_rev, /sys/class/infiniband/bnxt_reX/hca_type: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/mlx5_X/hw_rev, /sys/class/infiniband/mlx5_X/hca_type, /sys/class/infiniband/mlx5_X/reg_pages, /sys/class/infiniband/mlx5_X/fw_pages: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/<device-name>/hw_counters/lifespan, /sys/class/infiniband/<device-name>/ports/<port-num>/hw_counters/lifespan: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/cxgb4_X/hw_rev, /sys/class/infiniband/cxgb4_X/hca_type, /sys/class/infiniband/cxgb4_X/board_id: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/usnic_X/board_id, /sys/class/infiniband/usnic_X/config, /sys/class/infiniband/usnic_X/qp_per_vf, /sys/class/infiniband/usnic_X/max_vf, /sys/class/infiniband/usnic_X/cq_per_vf, /sys/class/infiniband/usnic_X/iface: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/leds/<led>/brightness: on file(s) sysfs-class-led sysfs-class-led-multicolor
2 duplicated entries for /sys/class/infiniband/qibX/ports/N/diag_counters/rc_resends, /sys/class/infiniband/qibX/ports/N/diag_counters/seq_naks, /sys/class/infiniband/qibX/ports/N/diag_counters/rdma_seq, /sys/class/infiniband/qibX/ports/N/diag_counters/rnr_naks, /sys/class/infiniband/qibX/ports/N/diag_counters/other_naks, /sys/class/infiniband/qibX/ports/N/diag_counters/rc_timeouts, /sys/class/infiniband/qibX/ports/N/diag_counters/look_pkts, /sys/class/infiniband/qibX/ports/N/diag_counters/pkt_drops, /sys/class/infiniband/qibX/ports/N/diag_counters/dma_wait, /sys/class/infiniband/qibX/ports/N/diag_counters/unaligned: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/bus/iio/devices/iio:deviceX/in_count0_quadrature_mode: on file(s) sysfs-bus-iio-timer-stm32 sysfs-bus-iio-lptimer-stm32
2 duplicated entries for /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency: on file(s) sysfs-bus-iio-frequency-adf4371 sysfs-bus-iio
2 duplicated entries for /sys/class/power_supply/<supply_name>/current_now: on file(s) sysfs-class-power
2 duplicated entries for /sys/class/infiniband/ocrdmaX/hca_type: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/hfi1_X/ports/N/sc2vl/[0-31], /sys/class/infiniband/hfi1_X/ports/N/sl2sc/[0-31], /sys/class/infiniband/hfi1_X/ports/N/vl2mtu/[0-15]: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/c2port/c2portX/flash_erase: on file(s) sysfs-c2port
2 duplicated entries for /sys/class/infiniband/i40iwX/hw_rev, /sys/class/infiniband/i40iwX/hca_type, /sys/class/infiniband/i40iwX/board_id: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/power_supply/<supply_name>/temp_min: on file(s) sysfs-class-power
2 duplicated entries for /sys/bus/w1/devices/.../eeprom: on file(s) sysfs-driver-w1_ds28e04 sysfs-driver-w1_therm
2 duplicated entries for /sys/bus/iio/devices/iio:deviceX/in_count0_preset: on file(s) sysfs-bus-iio-timer-stm32 sysfs-bus-iio-lptimer-stm32
2 duplicated entries for /sys/class/infiniband/<device>/ports/<port-num>/lid, /sys/class/infiniband/<device>/ports/<port-num>/rate, /sys/class/infiniband/<device>/ports/<port-num>/lid_mask_count, /sys/class/infiniband/<device>/ports/<port-num>/sm_sl, /sys/class/infiniband/<device>/ports/<port-num>/sm_lid, /sys/class/infiniband/<device>/ports/<port-num>/state, /sys/class/infiniband/<device>/ports/<port-num>/phys_state, /sys/class/infiniband/<device>/ports/<port-num>/cap_mask: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/<device>/node_desc: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/mthcaX/hw_rev, /sys/class/infiniband/mthcaX/hca_type, /sys/class/infiniband/mthcaX/board_id: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/leds/<led>/repeat: on file(s) sysfs-class-led-trigger-pattern sysfs-class-led-driver-el15203000
2 duplicated entries for /sys/class/power_supply/<supply_name>/temp_alert_min: on file(s) sysfs-class-power
2 duplicated entries for /sys/class/infiniband/hfi1_X/ports/N/CCMgtA/cc_settings_bin, /sys/class/infiniband/hfi1_X/ports/N/CCMgtA/cc_table_bin, /sys/class/infiniband/hfi1_X/ports/N/CCMgtA/cc_prescan: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/power_supply/<supply_name>/temp: on file(s) sysfs-class-power
2 duplicated entries for /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw, /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available: on file(s) sysfs-bus-iio-humidity-hdc2010 sysfs-bus-iio-humidity-hdc100x
2 duplicated entries for /sys/class/infiniband_mad/abi_version: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/<device>/fw_ver: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/infiniband/<device>/node_type, /sys/class/infiniband/<device>/node_guid, /sys/class/infiniband/<device>/sys_image_guid: on file(s) sysfs-class-infiniband sysfs-class-infiniband.org
2 duplicated entries for /sys/class/backlight/<backlight>/ambient_light_level: on file(s) sysfs-class-backlight-adp8860 sysfs-class-backlight-driver-adp8870
2 duplicated entries for /sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available: on file(s) sysfs-bus-iio-timer-stm32 sysfs-bus-iio-lptimer-stm32


