Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D732E1AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 10:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgLWJyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 04:54:24 -0500
Received: from ptr.189.cn ([183.61.185.103]:11411 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbgLWJyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 04:54:24 -0500
HMM_SOURCE_IP: 10.64.10.46:60142.1895318768
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.10.46])
        by 189.cn (HERMES) with SMTP id 1FB76101A04;
        Wed, 23 Dec 2020 17:51:33 +0800 (CST)
Received: from  ([10.64.8.33])
        by gateway-151646-dep-54888d799-2jgfg with ESMTP id 6ecfe81fd67243e39f5d77b91d3179f8 for greg@kroah.com;
        Wed Dec 23 17:51:35 2020
X-Transaction-ID: 6ecfe81fd67243e39f5d77b91d3179f8
X-filter-score: 
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 10.64.8.33
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     greg@kroah.com, linux-kernel@vger.kernel.org
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        chensong@tj.kylinos.cn, Song Chen <chensong_2000@189.cn>
Subject: [PATCH] staging: comedi: clean up debugging code in #if 0 or 1
Date:   Wed, 23 Dec 2020 17:51:41 +0800
Message-Id: <1608717101-32680-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a log of "#if 0" or "#if 1" in driver which cause
warning when running checkpatch.pl, they are supposed to be
cleaned up before release.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 drivers/staging/comedi/drivers/cb_pcidas64.c   | 95 --------------------------
 drivers/staging/comedi/drivers/dt2801.c        | 29 --------
 drivers/staging/comedi/drivers/ni_atmio16d.c   |  9 ---
 drivers/staging/comedi/drivers/ni_mio_common.c | 37 +---------
 drivers/staging/comedi/drivers/ni_mio_cs.c     | 10 ---
 drivers/staging/comedi/drivers/ni_pcidio.c     |  5 --
 drivers/staging/comedi/drivers/ni_pcimio.c     | 48 -------------
 drivers/staging/comedi/drivers/s526.c          | 49 -------------
 drivers/staging/comedi/drivers/s626.c          | 45 ------------
 9 files changed, 1 insertion(+), 326 deletions(-)

diff --git a/drivers/staging/comedi/drivers/cb_pcidas64.c b/drivers/staging/comedi/drivers/cb_pcidas64.c
index fa987bb..2d74ec9 100644
--- a/drivers/staging/comedi/drivers/cb_pcidas64.c
+++ b/drivers/staging/comedi/drivers/cb_pcidas64.c
@@ -998,101 +998,6 @@ static const struct pcidas64_board pcidas64_boards[] = {
 		.ai_fifo	= &ai_fifo_4020,
 		.has_8255	= 1,
 	},
-#if 0
-	/* The device id for these boards is unknown */
-
-	[BOARD_PCIDAS6402_16_JR] = {
-		.name		= "pci-das6402/16/jr",
-		.ai_se_chans	= 64,
-		.ai_bits	= 16,
-		.ai_speed	= 5000,
-		.ao_nchan	= 0,
-		.ao_scan_speed	= 10000,
-		.layout		= LAYOUT_64XX,
-		.ai_range_table	= &ai_ranges_64xx,
-		.ai_range_code	= ai_range_code_64xx,
-		.ai_fifo	= ai_fifo_64xx,
-		.has_8255	= 1,
-	},
-	[BOARD_PCIDAS64_M1_16_JR] = {
-		.name		= "pci-das64/m1/16/jr",
-		.ai_se_chans	= 64,
-		.ai_bits	= 16,
-		.ai_speed	= 1000,
-		.ao_nchan	= 0,
-		.ao_scan_speed	= 10000,
-		.layout		= LAYOUT_64XX,
-		.ai_range_table	= &ai_ranges_64_mx,
-		.ai_range_code	= ai_range_code_64_mx,
-		.ai_fifo	= ai_fifo_64xx,
-		.has_8255	= 1,
-	},
-	[BOARD_PCIDAS64_M2_16_JR] = {
-		.name = "pci-das64/m2/16/jr",
-		.ai_se_chans	= 64,
-		.ai_bits	= 16,
-		.ai_speed	= 500,
-		.ao_nchan	= 0,
-		.ao_scan_speed	= 10000,
-		.layout		= LAYOUT_64XX,
-		.ai_range_table	= &ai_ranges_64_mx,
-		.ai_range_code	= ai_range_code_64_mx,
-		.ai_fifo	= ai_fifo_64xx,
-		.has_8255	= 1,
-	},
-	[BOARD_PCIDAS64_M3_16_JR] = {
-		.name		= "pci-das64/m3/16/jr",
-		.ai_se_chans	= 64,
-		.ai_bits	= 16,
-		.ai_speed	= 333,
-		.ao_nchan	= 0,
-		.ao_scan_speed	= 10000,
-		.layout		= LAYOUT_64XX,
-		.ai_range_table	= &ai_ranges_64_mx,
-		.ai_range_code	= ai_range_code_64_mx,
-		.ai_fifo	= ai_fifo_64xx,
-		.has_8255	= 1,
-	},
-	[BOARD_PCIDAS64_M1_14] = {
-		.name		= "pci-das64/m1/14",
-		.ai_se_chans	= 64,
-		.ai_bits	= 14,
-		.ai_speed	= 1000,
-		.ao_nchan	= 2,
-		.ao_scan_speed	= 10000,
-		.layout		= LAYOUT_64XX,
-		.ai_range_table	= &ai_ranges_64_mx,
-		.ai_range_code	= ai_range_code_64_mx,
-		.ai_fifo	= ai_fifo_64xx,
-		.has_8255	= 1,
-	},
-	[BOARD_PCIDAS64_M2_14] = {
-		.name		= "pci-das64/m2/14",
-		.ai_se_chans	= 64,
-		.ai_bits	= 14,
-		.ai_speed	= 500,
-		.ao_nchan	= 2,
-		.ao_scan_speed	= 10000,
-		.layout		= LAYOUT_64XX,
-		.ai_range_table	= &ai_ranges_64_mx,
-		.ai_range_code	= ai_range_code_64_mx,
-		.ai_fifo	= ai_fifo_64xx,
-		.has_8255	= 1,
-	},
-	[BOARD_PCIDAS64_M3_14] = {
-		.name		= "pci-das64/m3/14",
-		.ai_se_chans	= 64,
-		.ai_bits	= 14,
-		.ai_speed	= 333,
-		.ao_nchan	= 2,
-		.ao_scan_speed	= 10000,
-		.layout		= LAYOUT_64XX,
-		.ai_range_table	= &ai_ranges_64_mx,
-		.ai_range_code	= ai_range_code_64_mx,
-		.ai_fifo	= ai_fifo_64xx,
-		.has_8255	= 1,
-	},
-#endif
 };
 
 static inline unsigned short se_diff_bit_6xxx(struct comedi_device *dev,
diff --git a/drivers/staging/comedi/drivers/dt2801.c b/drivers/staging/comedi/drivers/dt2801.c
index 0d571d8..bb01416 100644
--- a/drivers/staging/comedi/drivers/dt2801.c
+++ b/drivers/staging/comedi/drivers/dt2801.c
@@ -87,17 +87,6 @@
 #define DT2801_STATUS		1
 #define DT2801_CMD		1
 
-#if 0
-/* ignore 'defined but not used' warning */
-static const struct comedi_lrange range_dt2801_ai_pgh_bipolar = {
-	4, {
-		BIP_RANGE(10),
-		BIP_RANGE(5),
-		BIP_RANGE(2.5),
-		BIP_RANGE(1.25)
-	}
-};
-#endif
 static const struct comedi_lrange range_dt2801_ai_pgl_bipolar = {
 	4, {
 		BIP_RANGE(10),
@@ -107,17 +96,6 @@ static const struct comedi_lrange range_dt2801_ai_pgl_bipolar = {
 	}
 };
 
-#if 0
-/* ignore 'defined but not used' warning */
-static const struct comedi_lrange range_dt2801_ai_pgh_unipolar = {
-	4, {
-		UNI_RANGE(10),
-		UNI_RANGE(5),
-		UNI_RANGE(2.5),
-		UNI_RANGE(1.25)
-	}
-};
-#endif
 static const struct comedi_lrange range_dt2801_ai_pgl_unipolar = {
 	4, {
 		UNI_RANGE(10),
@@ -580,14 +558,7 @@ static int dt2801_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 	/* ai subdevice */
 	s->type = COMEDI_SUBD_AI;
 	s->subdev_flags = SDF_READABLE | SDF_GROUND;
-#if 1
 	s->n_chan = n_ai_chans;
-#else
-	if (it->options[2])
-		s->n_chan = board->ad_chan;
-	else
-		s->n_chan = board->ad_chan / 2;
-#endif
 	s->maxdata = (1 << board->adbits) - 1;
 	s->range_table = ai_range_lkup(board->adrangetype, it->options[3]);
 	s->insn_read = dt2801_ai_insn_read;
diff --git a/drivers/staging/comedi/drivers/ni_atmio16d.c b/drivers/staging/comedi/drivers/ni_atmio16d.c
index dffce1a..972e220 100644
--- a/drivers/staging/comedi/drivers/ni_atmio16d.c
+++ b/drivers/staging/comedi/drivers/ni_atmio16d.c
@@ -685,15 +685,6 @@ static int atmio16d_attach(struct comedi_device *dev,
 		s->type = COMEDI_SUBD_UNUSED;
 	}
 
-/* don't yet know how to deal with counter/timers */
-#if 0
-	s = &dev->subdevices[4];
-	/* do */
-	s->type = COMEDI_SUBD_TIMER;
-	s->n_chan = 0;
-	s->maxdata = 0
-#endif
-
 	return 0;
 }
 
diff --git a/drivers/staging/comedi/drivers/ni_mio_common.c b/drivers/staging/comedi/drivers/ni_mio_common.c
index 4f80a49..85ab35ed 100644
--- a/drivers/staging/comedi/drivers/ni_mio_common.c
+++ b/drivers/staging/comedi/drivers/ni_mio_common.c
@@ -795,18 +795,6 @@ static void ni_clear_ai_fifo(struct comedi_device *dev)
 		if (devpriv->is_625x) {
 			ni_writeb(dev, 0, NI_M_STATIC_AI_CTRL_REG(0));
 			ni_writeb(dev, 1, NI_M_STATIC_AI_CTRL_REG(0));
-#if 0
-			/*
-			 * The NI example code does 3 convert pulses for 625x
-			 * boards, But that appears to be wrong in practice.
-			 */
-			ni_stc_writew(dev, NISTC_AI_CMD1_CONVERT_PULSE,
-				      NISTC_AI_CMD1_REG);
-			ni_stc_writew(dev, NISTC_AI_CMD1_CONVERT_PULSE,
-				      NISTC_AI_CMD1_REG);
-			ni_stc_writew(dev, NISTC_AI_CMD1_CONVERT_PULSE,
-				      NISTC_AI_CMD1_REG);
-#endif
 		}
 	}
 }
@@ -2930,21 +2918,7 @@ static void ni_ao_cmd_personalize(struct comedi_device *dev,
 	  (board->ao_fifo_depth ?
 	    NISTC_AO_PERSONAL_FIFO_ENA : NISTC_AO_PERSONAL_DMA_PIO_CTRL)
 	  ;
-#if 0
-	/*
-	 * FIXME:
-	 * add something like ".has_individual_dacs = 0" to ni_board_struct
-	 * since, as F Hess pointed out, not all in m series have singles.  not
-	 * sure if e-series all have duals...
-	 */
 
-	/*
-	 * F Hess: windows driver does not set NISTC_AO_PERSONAL_NUM_DAC bit for
-	 * 6281, verified with bus analyzer.
-	 */
-	if (devpriv->is_m_series)
-		bits |= NISTC_AO_PERSONAL_NUM_DAC;
-#endif
 	ni_stc_writew(dev, bits, NISTC_AO_PERSONAL_REG);
 
 	ni_stc_writew(dev, NISTC_RESET_AO_CFG_END, NISTC_RESET_REG);
@@ -4857,21 +4831,12 @@ static int init_cs5529(struct comedi_device *dev)
 	unsigned int config_bits = CS5529_CFG_PORT_FLAG |
 				   CS5529_CFG_WORD_RATE_2180;
 
-#if 1
 	/* do self-calibration */
 	cs5529_config_write(dev, config_bits | CS5529_CFG_CALIB_BOTH_SELF,
 			    CS5529_CFG_REG);
 	/* need to force a conversion for calibration to run */
 	cs5529_do_conversion(dev, NULL);
-#else
-	/* force gain calibration to 1 */
-	cs5529_config_write(dev, 0x400000, CS5529_GAIN_REG);
-	cs5529_config_write(dev, config_bits | CS5529_CFG_CALIB_OFFSET_SELF,
-			    CS5529_CFG_REG);
-	if (cs5529_wait_for_idle(dev))
-		dev_err(dev->class_dev,
-			"timeout or signal in %s\n", __func__);
-#endif
+
 	return 0;
 }
 
diff --git a/drivers/staging/comedi/drivers/ni_mio_cs.c b/drivers/staging/comedi/drivers/ni_mio_cs.c
index 4f37b4e..7abd64b 100644
--- a/drivers/staging/comedi/drivers/ni_mio_cs.c
+++ b/drivers/staging/comedi/drivers/ni_mio_cs.c
@@ -100,16 +100,6 @@ static const struct ni_board_struct ni_boards[] = {
 		.ao_speed	= 1000000,
 		.caldac		= { ad8804_debug },
 	 },
-#if 0
-	{
-		.name		= "DAQCard-6715",
-		.device_id	= 0x0000,	/* unknown */
-		.n_aochan	= 8,
-		.ao_maxdata	= 0x0fff,
-		.ao_671x	= 8192,
-		.caldac		= { mb88341, mb88341 },
-	},
-#endif
 };
 
 #include "ni_mio_common.c"
diff --git a/drivers/staging/comedi/drivers/ni_pcidio.c b/drivers/staging/comedi/drivers/ni_pcidio.c
index 623f8d0..579d8eb 100644
--- a/drivers/staging/comedi/drivers/ni_pcidio.c
+++ b/drivers/staging/comedi/drivers/ni_pcidio.c
@@ -455,11 +455,6 @@ static irqreturn_t nidio_interrupt(int irq, void *d)
 
 out:
 	comedi_handle_events(dev, s);
-#if 0
-	if (!tag)
-		writeb(0x03, dev->mmio + MASTER_DMA_AND_INTERRUPT_CONTROL);
-#endif
-
 	spin_unlock(&dev->spinlock);
 	return IRQ_HANDLED;
 }
diff --git a/drivers/staging/comedi/drivers/ni_pcimio.c b/drivers/staging/comedi/drivers/ni_pcimio.c
index 6c813a4..8b716ed 100644
--- a/drivers/staging/comedi/drivers/ni_pcimio.c
+++ b/drivers/staging/comedi/drivers/ni_pcimio.c
@@ -481,43 +481,6 @@ static const struct ni_board_struct ni_boards[] = {
 		.ao_speed	= 250,
 		.caldac		= { ad8804, ad8804 },
 	},
-#if 0
-	/* The 6115 boards probably need their own driver */
-	[BOARD_PCI6115] = {	/* .device_id = 0x2ed0, */
-		.name		= "pci-6115",
-		.n_adchan	= 4,
-		.ai_maxdata	= 0x0fff,
-		.ai_fifo_depth	= 8192,
-		.gainlkup	= ai_gain_611x,
-		.ai_speed	= 100,
-		.n_aochan	= 2,
-		.ao_maxdata	= 0xffff,
-		.ao_671x	= 1,
-		.ao_fifo_depth	= 2048,
-		.ao_speed	= 250,
-		.reg_611x	= 1,
-		/* XXX */
-		.caldac		= { ad8804_debug, ad8804_debug, ad8804_debug },
-	},
-#endif
-#if 0
-	[BOARD_PXI6115] = {	/* .device_id = ????, */
-		.name		= "pxi-6115",
-		.n_adchan	= 4,
-		.ai_maxdata	= 0x0fff,
-		.ai_fifo_depth	= 8192,
-		.gainlkup	= ai_gain_611x,
-		.ai_speed	= 100,
-		.n_aochan	= 2,
-		.ao_maxdata	= 0xffff,
-		.ao_671x	= 1,
-		.ao_fifo_depth	= 2048,
-		.ao_speed	= 250,
-		.reg_611x	= 1,
-		/* XXX */
-		.caldac		= { ad8804_debug, ad8804_debug, ad8804_debug },
-	},
-#endif
 	[BOARD_PCI6711] = {
 		.name = "pci-6711",
 		.n_aochan	= 4,
@@ -569,17 +532,6 @@ static const struct ni_board_struct ni_boards[] = {
 		.reg_type	= ni_reg_6711,
 		.caldac		= { ad8804_debug },
 	},
-#if 0
-	[BOARD_PXI6731] = {	/* .device_id = ????, */
-		.name		= "pxi-6731",
-		.n_aochan	= 4,
-		.ao_maxdata	= 0xffff,
-		.ao_fifo_depth	= 8192,
-		.ao_range_table	= &range_bipolar10,
-		.reg_type	= ni_reg_6711,
-		.caldac		= { ad8804_debug },
-	},
-#endif
 	[BOARD_PCI6733] = {
 		.name		= "pci-6733",
 		.n_aochan	= 8,
diff --git a/drivers/staging/comedi/drivers/s526.c b/drivers/staging/comedi/drivers/s526.c
index 085cf5b..7f3c59e 100644
--- a/drivers/staging/comedi/drivers/s526.c
+++ b/drivers/staging/comedi/drivers/s526.c
@@ -229,7 +229,6 @@ static int s526_gpct_insn_config(struct comedi_device *dev,
 		 */
 		devpriv->gpct_config[chan] = data[0];
 
-#if 1
 		/*  Set Counter Mode Register */
 		val = data[1] & 0xffff;
 		outw(val, dev->iobase + S526_GPCT_MODE_REG(chan));
@@ -246,54 +245,6 @@ static int s526_gpct_insn_config(struct comedi_device *dev,
 			 *      dev->iobase + S526_GPCT_CTRL_REG(chan));
 			 */
 		}
-#else
-		val = S526_GPCT_MODE_CTDIR_CTRL_QUAD;
-
-		/*  data[1] contains GPCT_X1, GPCT_X2 or GPCT_X4 */
-		if (data[1] == GPCT_X2)
-			val |= S526_GPCT_MODE_CLK_SRC_QUADX2;
-		else if (data[1] == GPCT_X4)
-			val |= S526_GPCT_MODE_CLK_SRC_QUADX4;
-		else
-			val |= S526_GPCT_MODE_CLK_SRC_QUADX1;
-
-		/*  When to take into account the indexpulse: */
-		/*
-		 * if (data[2] == GPCT_IndexPhaseLowLow) {
-		 * } else if (data[2] == GPCT_IndexPhaseLowHigh) {
-		 * } else if (data[2] == GPCT_IndexPhaseHighLow) {
-		 * } else if (data[2] == GPCT_IndexPhaseHighHigh) {
-		 * }
-		 */
-		/*  Take into account the index pulse? */
-		if (data[3] == GPCT_RESET_COUNTER_ON_INDEX) {
-			/*  Auto load with INDEX^ */
-			val |= S526_GPCT_MODE_AUTOLOAD_IXRISE;
-		}
-
-		/*  Set Counter Mode Register */
-		val = data[1] & 0xffff;
-		outw(val, dev->iobase + S526_GPCT_MODE_REG(chan));
-
-		/*  Load the pre-load register */
-		s526_gpct_write(dev, chan, data[2]);
-
-		/*  Write the Counter Control Register */
-		if (data[3])
-			outw(data[3] & 0xffff,
-			     dev->iobase + S526_GPCT_CTRL_REG(chan));
-
-		/*  Reset the counter if it is software preload */
-		if ((val & S526_GPCT_MODE_AUTOLOAD_MASK) ==
-		    S526_GPCT_MODE_AUTOLOAD_NONE) {
-			/*  Reset the counter */
-			outw(S526_GPCT_CTRL_CT_RESET,
-			     dev->iobase + S526_GPCT_CTRL_REG(chan));
-			/*  Load the counter from PR0 */
-			outw(S526_GPCT_CTRL_CT_LOAD,
-			     dev->iobase + S526_GPCT_CTRL_REG(chan));
-		}
-#endif
 		break;
 
 	case INSN_CONFIG_GPCT_SINGLE_PULSE_GENERATOR:
diff --git a/drivers/staging/comedi/drivers/s626.c b/drivers/staging/comedi/drivers/s626.c
index e7aba93..5ff33c4 100644
--- a/drivers/staging/comedi/drivers/s626.c
+++ b/drivers/staging/comedi/drivers/s626.c
@@ -2255,51 +2255,6 @@ static int s626_initialize(struct comedi_device *dev)
 	/* Disable RPS timeouts */
 	writel(0, dev->mmio + S626_P_RPS1_TOUT);
 
-#if 0
-	/*
-	 * SAA7146 BUG WORKAROUND
-	 *
-	 * Initialize SAA7146 ADC interface to a known state by
-	 * invoking ADCs until FB BUFFER 1 register shows that it
-	 * is correctly receiving ADC data. This is necessary
-	 * because the SAA7146 ADC interface does not start up in
-	 * a defined state after a PCI reset.
-	 */
-	{
-		struct comedi_subdevice *s = dev->read_subdev;
-		u8 poll_list;
-		u16 adc_data;
-		u16 start_val;
-		u16 index;
-		unsigned int data[16];
-
-		/* Create a simple polling list for analog input channel 0 */
-		poll_list = S626_EOPL;
-		s626_reset_adc(dev, &poll_list);
-
-		/* Get initial ADC value */
-		s626_ai_rinsn(dev, s, NULL, data);
-		start_val = data[0];
-
-		/*
-		 * VERSION 2.01 CHANGE: TIMEOUT ADDED TO PREVENT HANGED
-		 * EXECUTION.
-		 *
-		 * Invoke ADCs until the new ADC value differs from the initial
-		 * value or a timeout occurs.  The timeout protects against the
-		 * possibility that the driver is restarting and the ADC data is
-		 * a fixed value resulting from the applied ADC analog input
-		 * being unusually quiet or at the rail.
-		 */
-		for (index = 0; index < 500; index++) {
-			s626_ai_rinsn(dev, s, NULL, data);
-			adc_data = data[0];
-			if (adc_data != start_val)
-				break;
-		}
-	}
-#endif	/* SAA7146 BUG WORKAROUND */
-
 	/*
 	 * Initialize the DAC interface
 	 */
-- 
2.7.4

